#!/usr/bin/env bash
# Switch the active opencode model preset (go = paid go models, free = free tier).
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
name=${1:-go}
[[ $name == go || $name == free ]] || { echo "usage: ${0##*/} [go|free]" >&2; exit 1; }

models=$(cd "$here/.." && pwd)/models
src=$models/$name.json
[[ -f $src ]] || { echo "missing preset: $src" >&2; exit 1; }

active=$models/active.json
cp "$src" "$active"
echo "active preset: $name"
echo "use it with: OPENCODE_CONFIG=$active opencode"
