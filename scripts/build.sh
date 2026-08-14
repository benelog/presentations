#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIST="$ROOT/dist"
BASE_PATH="${BASE_PATH:-/presentations}"

# 증분 빌드: dist/ 를 지우지 않고, 소스가 바뀐 덱만 다시 빌드한다.
# (덱 디렉터리 + themes/ + build.sh + package-lock.json 의 해시를 dist/<덱>/.build-hash 에 기록)
mkdir -p "$DIST"

SLIDEV="$ROOT/node_modules/.bin/slidev"
if [ ! -x "$SLIDEV" ]; then
  echo "slidev not found. Run 'npm install' first." >&2
  exit 1
fi

shopt -s nullglob

declare -a entries=()

# 최신 발표가 먼저 오도록 시간 역순으로 빌드/나열
mapfile -t slides < <(printf '%s\n' "$ROOT"/[0-9]*/slides.md | sort -r)

deck_hash() {
  {
    sha256sum "$ROOT/scripts/build.sh" "$ROOT/package-lock.json"
    find "$1" "$ROOT/themes" -type f -not -path '*/node_modules/*' -not -path '*/.*' -print0 \
      | sort -z | xargs -0 sha256sum
  } | sha256sum | cut -d' ' -f1
}

for slide in "${slides[@]}"; do
  [ -f "$slide" ] || continue
  dir="$(dirname "$slide")"
  name="$(basename "$dir")"
  out_dir="$DIST/$name"

  hash="$(deck_hash "$dir")"
  if [ -f "$out_dir/index.html" ] && [ -f "$out_dir/.build-hash" ] \
     && [ "$(cat "$out_dir/.build-hash")" = "$hash" ]; then
    echo "→ skipping $name (unchanged)"
  else
    echo "→ building $name"
    rm -rf "$out_dir"
    "$SLIDEV" build "$slide" --base "$BASE_PATH/$name/" --out "$out_dir"
    "$SLIDEV" export "$slide" --output "$out_dir/slides.pdf" || true

    # Copy assets referenced at runtime (frontmatter images 등은 번들되지 않음)
    for asset in "$dir"/*; do
      [ -f "$asset" ] || continue
      case "$asset" in
        *.md|*.drawio|*/.*) continue ;;
      esac
      cp "$asset" "$out_dir/"
    done
    printf '%s' "$hash" > "$out_dir/.build-hash"
  fi

  title="$(grep -m1 '^# ' "$slide" | sed 's/^# *//' || true)"
  [ -z "$title" ] && title="$name"
  # headmatter(첫 --- 쌍 사이)의 event: 필드 = 발표한 행사
  event="$(awk '/^---$/{c++; next} c==1 && sub(/^event: */, ""){print; exit} c>=2{exit}' "$slide")"
  # event_url: 필드가 있으면 행사 소개 페이지로 링크를 건다
  event_url="$(awk '/^---$/{c++; next} c==1 && sub(/^event_url: */, ""){print; exit} c>=2{exit}' "$slide")"
  entries+=("$name|$event|$event_url|$title")
done

# 소스에서 사라진 덱은 dist 에서도 제거
for built in "$DIST"/[0-9]*/; do
  [ -d "$built" ] || continue
  name="$(basename "$built")"
  [ -f "$ROOT/$name/slides.md" ] || rm -rf "$built"
done

cat > "$DIST/index.html" <<HTML
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Presentations · benelog</title>
<style>
  :root { color-scheme: light dark; }
  body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans KR", sans-serif;
    max-width: 720px; margin: 4rem auto; padding: 0 1.5rem; line-height: 1.6;
  }
  h1 { font-size: 1.5rem; margin-bottom: 2rem; }
  ul { list-style: none; padding: 0; }
  li { margin: 0.75rem 0; padding: 0.75rem 1rem; border: 1px solid color-mix(in srgb, currentColor 15%, transparent); border-radius: 8px; }
  li a { font-weight: 600; text-decoration: none; }
  li a:hover { text-decoration: underline; }
  .meta { display: block; font-size: 0.85rem; opacity: 0.65; margin-top: 0.25rem; }
  .pdf { font-size: 0.85rem; margin-left: 0.5rem; opacity: 0.7; }
  .meta a.event { font-weight: 400; color: inherit; text-decoration: underline; text-underline-offset: 2px; }
</style>
</head>
<body>
<h1>Presentations</h1>
<ul>
HTML

for entry in "${entries[@]}"; do
  name="${entry%%|*}"
  rest="${entry#*|}"
  event="${rest%%|*}"
  rest="${rest#*|}"
  event_url="${rest%%|*}"
  title="${rest#*|}"
  date="${name%%-*}"
  pretty_date="${date:0:4}-${date:4:2}-${date:6:2}"
  meta="$pretty_date"
  if [ -n "$event" ]; then
    if [ -n "$event_url" ]; then
      meta="$pretty_date · <a class=\"event\" href=\"$event_url\">$event</a>"
    else
      meta="$pretty_date · $event"
    fi
  fi
  cat >> "$DIST/index.html" <<HTML
  <li>
    <a href="./$name/">$title</a>
    <a class="pdf" href="./$name/slides.pdf">PDF</a>
    <span class="meta">$meta</span>
  </li>
HTML
done

cat >> "$DIST/index.html" <<HTML
</ul>
</body>
</html>
HTML

echo "✓ built ${#entries[@]} presentation(s) → $DIST"
