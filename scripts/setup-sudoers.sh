#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"
LIMPANTE="$HOME/dotfiles/scripts/limpante"
USER_NAME="$(id -un)"

tmp="$(mktemp)"

# Show asterisks (*) when typing the sudo password
echo 'Defaults pwfeedback' >"$tmp"

# Run limpante via systemd timer with sudo, without password prompt
echo "$USER_NAME ALL=(root) NOPASSWD: $LIMPANTE" >>"$tmp"

# Validate before installing, otherwise sudoers breaks sudo on the machine
sudo sh -c "visudo -cf '$tmp' >/dev/null && install -m 0440 '$tmp' /etc/sudoers.d/dotfiles"
rm -f "$tmp"

echo "==> sudoers configured (pwfeedback + NOPASSWD limpante)"
