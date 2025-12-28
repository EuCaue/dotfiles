#!/usr/bin/env bash

if command -v megasync >/dev/null 2>&1; then
  megasync
fi

"$HOME"/dotfiles/scripts/zk-weekly-backup.sh
