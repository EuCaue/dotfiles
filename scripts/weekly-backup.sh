#!/usr/bin/env bash

set -Eeuo pipefail

if "$HOME"/dotfiles/scripts/backup-dconf.sh; then
  echo "dconf backup finished"
else
  echo "Skipping dconf backup"
fi

if command -v megasync >/dev/null 2>&1; then
  megasync
fi

"$HOME"/dotfiles/scripts/zk-weekly-backup.sh
