#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIST="$ROOT/dist"
BASE_PATH="${BASE_PATH:-/presentations}"

rm -rf "$DIST"
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

for slide in "${slides[@]}"; do
  [ -f "$slide" ] || continue
  dir="$(dirname "$slide")"
  name="$(basename "$dir")"
  out_dir="$DIST/$name"

  echo "→ building $name"
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

  title="$(grep -m1 '^# ' "$slide" | sed 's/^# *//' || true)"
  [ -z "$title" ] && title="$name"
  # headmatter(첫 --- 쌍 사이)의 event: 필드 = 발표한 행사
  event="$(awk '/^---$/{c++; next} c==1 && sub(/^event: */, ""){print; exit} c>=2{exit}' "$slide")"
  entries+=("$name|$event|$title")
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
  title="${rest#*|}"
  date="${name%%-*}"
  pretty_date="${date:0:4}-${date:4:2}-${date:6:2}"
  meta="$pretty_date"
  [ -n "$event" ] && meta="$pretty_date · $event"
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
