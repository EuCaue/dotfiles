#!/usr/bin/env bash

if command -v "megasync"; then
  megasync &
fi

"$HOME"/dotfiles/scripts/zk-weekly-backup.sh &
