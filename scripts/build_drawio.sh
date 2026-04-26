#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

DRAWIO="${DRAWIO:-drawio}"
if ! command -v "$DRAWIO" >/dev/null 2>&1; then
  echo "drawio CLI not found. Install via: sudo snap install drawio" >&2
  exit 1
fi

HEIGHT="${HEIGHT:-500}"
BORDER="${BORDER:-10}"

shopt -s nullglob

count=0
for src in "$ROOT"/[0-9]*/*.drawio; do
  out="${src%.drawio}.png"
  rel="${src#$ROOT/}"
  echo "→ $rel → $(basename "$out") (h:$HEIGHT, transparent)"
  "$DRAWIO" -x -f png -t -b "$BORDER" --height "$HEIGHT" -o "$out" "$src" 2>/dev/null
  count=$((count + 1))
done

echo "✓ exported $count drawio file(s)"
