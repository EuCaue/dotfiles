#!/usr/bin/env bash
set -Eeuo pipefail

DOTFILES_DIR="$HOME/dotfiles"
LAYOUT_SNIPPET="$DOTFILES_DIR/dotconfig/keyboard"
SYSTEM_LAYOUT_FILE="/usr/share/X11/xkb/symbols/us"
BACKUP_FILE="${SYSTEM_LAYOUT_FILE}.dotfiles-backup"

if [ ! -f "$LAYOUT_SNIPPET" ]; then
  echo "Missing layout snippet: $LAYOUT_SNIPPET"
  exit 1
fi

if [ ! -f "$SYSTEM_LAYOUT_FILE" ]; then
  echo "System XKB file not found: $SYSTEM_LAYOUT_FILE"
  exit 1
fi

if ! grep -q '^xkb_symbols "intl" {$' "$LAYOUT_SNIPPET"; then
  echo "Layout snippet must define xkb_symbols \"intl\""
  exit 1
fi

echo "==> Installing custom us(intl) XKB block"

snippet_file="$(mktemp)"
patched_file="$(mktemp)"

cleanup() {
  rm -f "$snippet_file" "$patched_file"
}

trap cleanup EXIT

# Drop any leading blank lines so the block is inserted cleanly.
awk 'seen || NF { seen = 1; print }' "$LAYOUT_SNIPPET" >"$snippet_file"

awk -v block_file="$snippet_file" '
BEGIN {
  while ((getline line < block_file) > 0) {
    block = block line ORS
  }
  close(block_file)
}

skipping {
  if ($0 ~ /^};$/) {
    skipping = 0
  }
  next
}

$0 == "partial alphanumeric_keys" {
  if ((getline next_line) <= 0) {
    print
    next
  }

  if (next_line == "xkb_symbols \"intl\" {") {
    printf "%s", block
    replaced = 1
    skipping = 1
    next
  }

  print
  print next_line
  next
}

{ print }

END {
  if (!replaced) {
    exit 2
  }
}
' "$SYSTEM_LAYOUT_FILE" >"$patched_file"

if [ ! -f "$BACKUP_FILE" ]; then
  echo "==> Backing up original XKB file"
  sudo cp "$SYSTEM_LAYOUT_FILE" "$BACKUP_FILE"
fi

if cmp -s "$patched_file" "$SYSTEM_LAYOUT_FILE"; then
  echo "us(intl) already matches dotfiles snippet"
  exit 0
fi

echo "==> Replacing us(intl) block in $SYSTEM_LAYOUT_FILE"
sudo install -m 0644 "$patched_file" "$SYSTEM_LAYOUT_FILE"

echo "==> Keyboard layout updated"
echo "Logout/login may be required for the new layout to take effect"
