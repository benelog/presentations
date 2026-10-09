#!/usr/bin/env bash
# Build a single presentation directory to dist/<name>/.
# Usage: bash scripts/build_slide.sh <directory>
#   e.g. bash scripts/build_slide.sh 20260528-yonsei-stats-rc101
set -Eeuo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <directory>" >&2
  echo "  e.g. $0 20260528-yonsei-stats-rc101" >&2
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
INPUT="${1%/}"

# Accept either "20260528-yonsei-stats-rc101" (relative to repo root), a relative path
# from cwd, or an absolute path.
if [ -d "$ROOT/$INPUT" ]; then
  DIR="$ROOT/$INPUT"
elif [ -d "$INPUT" ]; then
  DIR="$(cd "$INPUT" && pwd)"
else
  echo "Error: directory not found: $INPUT" >&2
  exit 1
fi

SLIDE="$DIR/slides.md"
if [ ! -f "$SLIDE" ]; then
  echo "Error: $SLIDE not found" >&2
  exit 1
fi

NAME="$(basename "$DIR")"
DIST="$ROOT/dist/$NAME"
mkdir -p "$DIST"

MARP="${MARP:-marp}"
if ! command -v "$MARP" >/dev/null 2>&1; then
  MARP="npx --yes @marp-team/marp-cli"
fi

echo "→ building $NAME"
$MARP --html --allow-local-files "--theme-set=$ROOT/themes" \
  -o "$DIST/index.html" "$SLIDE"
$MARP --pdf --allow-local-files "--theme-set=$ROOT/themes" \
  -o "$DIST/slides.pdf" "$SLIDE" || true

# Copy assets (images, etc.) referenced from the slide.
shopt -s nullglob
for asset in "$DIR"/*; do
  [ -f "$asset" ] || continue
  case "$asset" in
    *.md|*.drawio|*/.*) continue ;;
  esac
  cp "$asset" "$DIST/"
done

echo "✓ built $NAME → $DIST"
