#!/usr/bin/env zsh

DATE=$(date +%F)
FILE="journal/$DATE"
VAULT="$HOME/Documents/zk"
FILEPATH="$VAULT/$FILE.md"
IS_NEW=false

if [[ ! -f "$FILEPATH" ]]; then
  IS_NEW=true
fi

open_uri() {
  if command -v obsidian >/dev/null 2>&1; then
    obsidian "$1"
  else
    flatpak run md.obsidian.Obsidian "$1"
  fi
}

if $IS_NEW; then
  open_uri "obsidian://daily?vault=zk"
else
  open_uri "obsidian://open?vault=zk&file=$FILE"
fi