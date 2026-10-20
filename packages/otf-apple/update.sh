#!/usr/bin/env bash
set -euo pipefail

file="$(dirname "$(readlink -f "$0")")/default.nix"

grep -oP 'url = "\K[^"]+' "$file" | while read -r url; do
  echo "Fetching $url" >&2
  hash=$(nix store prefetch-file --json "$url" | jq -r .hash)
  sed -i "\|url = \"$url\"|{n;s|sha256 = \".*\"|sha256 = \"$hash\"|}" "$file"
  echo "  $hash" >&2
done
