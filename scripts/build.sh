#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIST="$ROOT/dist"

rm -rf "$DIST"
mkdir -p "$DIST"

MARP="${MARP:-marp}"
if ! command -v "$MARP" >/dev/null 2>&1; then
  MARP="npx --yes @marp-team/marp-cli"
fi

shopt -s nullglob

declare -a entries=()

for slide in "$ROOT"/[0-9]*/slides.md; do
  dir="$(dirname "$slide")"
  name="$(basename "$dir")"
  out_dir="$DIST/$name"
  mkdir -p "$out_dir"

  echo "→ building $name"
  $MARP --html --allow-local-files "--theme-set=$ROOT/themes" \
    -o "$out_dir/index.html" "$slide"
  $MARP --pdf --allow-local-files "--theme-set=$ROOT/themes" \
    -o "$out_dir/slides.pdf" "$slide" || true

  title="$(grep -m1 '^# ' "$slide" | sed 's/^# *//' || true)"
  [ -z "$title" ] && title="$name"
  entries+=("$name|$title")
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
  title="${entry#*|}"
  date="${name%%-*}"
  pretty_date="${date:0:4}-${date:4:2}-${date:6:2}"
  cat >> "$DIST/index.html" <<HTML
  <li>
    <a href="./$name/">$title</a>
    <a class="pdf" href="./$name/slides.pdf">PDF</a>
    <span class="meta">$pretty_date · $name</span>
  </li>
HTML
done

cat >> "$DIST/index.html" <<HTML
</ul>
</body>
</html>
HTML

echo "✓ built ${#entries[@]} presentation(s) → $DIST"
