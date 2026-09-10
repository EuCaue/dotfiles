#!/usr/bin/env bash
# Toggle between light and dark mode by calling style.sh with the opposite mode.
set -e

STYLE="$HOME/dotfiles/scripts/style.sh"

if gsettings get org.gnome.desktop.interface color-scheme | grep -q "dark"; then
  exec "$STYLE" light
else
  exec "$STYLE" dark
fi
