#!/usr/bin/env zsh

URI="obsidian://open?vault=zk&file=journal/$(date +%F)"

command -v obsidian >/dev/null 2>&1 \
  && exec obsidian "$URI"

exec flatpak run md.obsidian.Obsidian "$URI"
