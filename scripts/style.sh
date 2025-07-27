#!/usr/bin/env sh

DEFAULT_CURSOR_LIGHT="macOS-White"
DEFAULT_BACKGROUND_LIGHT="$HOME/Pictures/wallpapers/wallhaven-48xr3o.jpg"
DEFAULT_CURSOR_DARK="macOS"
DEFAULT_BACKGROUND_DARK="$HOME/Pictures/wallpapers/1357320.jpeg"
FLAG_FILE="/tmp/style_has_runned"

if [ ! -f "$FLAG_FILE" ]; then
  touch "$FLAG_FILE"
  exit 0
fi

for arg in "$@"; do
  case $arg in
  *=*)
    key="${arg%%=*}"
    value="${arg#*=}"
    export "$key"="$value"
    ;;
  esac
done

NVIM_FILE="${NVIM_FILE:-$HOME/.config/nvim/lua/user/core/options.lua}"
CURSOR_LIGHT="${CURSOR_LIGHT:-$DEFAULT_CURSOR_LIGHT}"
CURSOR_DARK="${CURSOR_DARK:-$DEFAULT_CURSOR_DARK}"
BACKGROUND_DARK="${BACKGROUND_DARK:-$DEFAULT_BACKGROUND_DARK}"
BACKGROUND_LIGHT="${BACKGROUND_LIGHT:-$DEFAULT_BACKGROUND_LIGHT}"

if [ "$1" = "dark" ]; then
  echo "dark mode"
  gsettings set org.gnome.desktop.interface color-scheme "'prefer-dark'"
  gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_DARK"
  gsettings set org.gnome.desktop.background picture-uri-dark "file://$BACKGROUND_DARK"
  sed -i "s/light/dark/" "$NVIM_FILE"
  notify-send "Dark mode"
fi

if [ "$1" = "light" ]; then
  echo "light mode"
  gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_LIGHT"
  gsettings set org.gnome.desktop.background picture-uri "file://$BACKGROUND_LIGHT" &&
    sed -i "s/dark/light/" "$NVIM_FILE"
  gsettings set org.gnome.desktop.interface color-scheme "'prefer-light'"
  notify-send "Light mode"
fi
