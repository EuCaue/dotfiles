#!/usr/bin/env sh

FLAG_FILE="/tmp/style_has_runned"

if [ ! -f "$FLAG_FILE" ]; then
  touch "$FLAG_FILE"
  exit 0
fi

NVIM_FILE=$HOME/.config/nvim/lua/user/core/options.lua
CURSOR_NAME_LIGHT="adwhite-new"
CURSOR_NAME_DARK="adwaita-new"
BACKGROUND_DARK="$HOME/Pictures/wallpapers/1357320.jpeg"
BACKGROUND_LIGHT="$HOME/Pictures/wallpapers/wallhaven-48xr3o.jpg"

if [ "$1" = "dark" ]; then
  echo "dark mode"
  gsettings set org.gnome.desktop.interface color-scheme "'prefer-dark'"
  gsettings set org.gnome.desktop.interface cursor-theme $CURSOR_NAME_DARK
  gsettings set org.gnome.desktop.background picture-uri-dark "file://$BACKGROUND_DARK"
  sed -i "s/light/dark/" "$NVIM_FILE"
  notify-send "Dark mode"
fi

if [ "$1" = "light" ]; then
  echo "light mode"
  gsettings set org.gnome.desktop.interface cursor-theme $CURSOR_NAME_LIGHT
  gsettings set org.gnome.desktop.background picture-uri "file://$BACKGROUND_LIGHT" &&
    sed -i "s/dark/light/" "$NVIM_FILE"
  gsettings set org.gnome.desktop.interface color-scheme "'prefer-light'"
  notify-send "Light mode"
fi
