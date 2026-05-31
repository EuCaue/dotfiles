#!/usr/bin/env bash
set -Eeuo pipefail

umask 077

DOTFILES_DIR="$HOME/dotfiles"
LOCAL_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
RECIPIENT_FILE="$LOCAL_DATA_DIR/dconf-backup.recipient"
OUTPUT_FILE="$DOTFILES_DIR/dotconfig/gnome-settings.conf.gpg"
HASH_FILE="$DOTFILES_DIR/dotconfig/gnome-settings.conf.sha256"

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

read_recipient_from_file() {
  local line

  [ -f "$RECIPIENT_FILE" ] || return 1

  while IFS= read -r line; do
    if [ -n "$line" ]; then
      printf '%s\n' "$line"
      return 0
    fi
  done <"$RECIPIENT_FILE"

  return 1
}

recipient="${BACKUP_DCONF_GPG_RECIPIENT:-}"

if [ -z "$recipient" ]; then
  recipient="$(read_recipient_from_file || true)"
fi

if ! has_cmd dconf; then
  echo "dconf not found"
  exit 1
fi

if ! has_cmd gpg; then
  echo "gpg not found"
  exit 1
fi

if ! has_cmd sha256sum; then
  echo "sha256sum not found"
  exit 1
fi

if [ -z "$recipient" ]; then
  echo "Missing GPG recipient. Set BACKUP_DCONF_GPG_RECIPIENT or create $RECIPIENT_FILE"
  exit 1
fi

if ! gpg --list-secret-keys --with-colons "$recipient" | grep -q '^sec:'; then
  echo "No secret GPG key found for recipient: $recipient"
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT_FILE")"

dump_file="$(mktemp)"
encrypted_file="$(mktemp)"

cleanup() {
  rm -f "$dump_file" "$encrypted_file"
}

trap cleanup EXIT

echo "==> Dumping dconf database"
dconf dump / >"$dump_file"

current_hash="$(sha256sum "$dump_file")"
current_hash="${current_hash%% *}"

if [ -f "$HASH_FILE" ]; then
  IFS= read -r existing_hash <"$HASH_FILE" || true
  if [ "$existing_hash" = "$current_hash" ]; then
    echo "dconf backup unchanged"
    exit 0
  fi
fi

echo "==> Encrypting dconf backup"
gpg --batch --yes \
  --trust-model always \
  --encrypt \
  --recipient "$recipient" \
  --output "$encrypted_file" \
  "$dump_file"

mv "$encrypted_file" "$OUTPUT_FILE"
printf '%s\n' "$current_hash" >"$HASH_FILE"

echo "dconf backup updated: $OUTPUT_FILE"
