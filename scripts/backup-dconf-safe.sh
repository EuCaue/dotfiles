#!/usr/bin/env bash
set -Eeuo pipefail

DOTFILES_DIR="$HOME/dotfiles"
OUTPUT_FILE="$DOTFILES_DIR/dotconfig/gnome-settings-safe.conf"
HASH_FILE="$DOTFILES_DIR/dotconfig/gnome-settings-safe.conf.sha256"

SAFE_PATHS=(
  "/org/gnome/desktop/a11y/keyboard/"
  "/org/gnome/desktop/peripherals/keyboard/"
  "/org/gnome/desktop/wm/preferences/"
  "/org/gnome/desktop/wm/keybindings/"
  "/org/gnome/desktop/input-sources/"
  "/org/gnome/desktop/interface/"
  "/org/gnome/shell/keybindings/"
  "/org/gnome/mutter/keybindings/"
  "/org/gnome/settings-daemon/plugins/media-keys/"
  "/org/gnome/TextEditor/"
)

if ! command -v dconf >/dev/null 2>&1; then
  echo "dconf not found"
  exit 1
fi

tmp_file="$(mktemp)"
cleanup() {
  rm -f "$tmp_file"
}
trap cleanup EXIT

allow_expr=""
for path in "${SAFE_PATHS[@]}"; do
  allow_expr="${allow_expr} ${path}"
done

dconf dump / | awk -v paths="$allow_expr" '
BEGIN {
  n = split(paths, arr, " ")
  for (i = 1; i <= n; i++) {
    p = arr[i]
    sub(/^\//, "", p)
    sub(/\/$/, "", p)
    allow[p] = 1
  }
}
/^\[/ {
  s = $0
  sub(/^\[/, "", s)
  sub(/\]$/, "", s)
  keep = 0
  for (p in allow) {
    if (s == p || index(s, p "/") == 1) {
      keep = 1
      break
    }
  }
  if (keep) print
  next
}
keep { print }
' >"$tmp_file"

current_hash="$(sha256sum "$tmp_file")"
current_hash="${current_hash%% *}"

if [ -f "$HASH_FILE" ]; then
  IFS= read -r existing_hash <"$HASH_FILE" || true
  if [ "$existing_hash" = "$current_hash" ]; then
    echo "dconf safe backup unchanged"
    exit 0
  fi
fi

mkdir -p "$(dirname "$OUTPUT_FILE")"
mv "$tmp_file" "$OUTPUT_FILE"
printf '%s\n' "$current_hash" >"$HASH_FILE"

echo "dconf safe backup updated: $OUTPUT_FILE"
