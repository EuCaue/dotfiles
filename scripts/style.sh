#!/usr/bin/env zsh

DEFAULT_CURSOR_LIGHT="macOS-White"
DEFAULT_CURSOR_SIZE_LIGHT="36"
DEFAULT_BACKGROUND_LIGHT="$HOME/Pictures/wallpapers/wallhaven-vgdq33_1920x1080.png"
DEFAULT_BRIGHTNESS_LIGHT="45"
DEFAULT_CURSOR_DARK="macOS"
DEFAULT_CURSOR_SIZE_DARK="36"
DEFAULT_BACKGROUND_DARK="$HOME/Pictures/wallpapers/coffee-flowers-and-books-dark-academia-desktop-3fbe7rq72r6036cc-1118522375.jpg"
DEFAULT_BRIGHTNESS_DARK="75"
FLAG_FILE="/tmp/style_has_runned"
source $HOME/dotfiles/dotconfig/zsh/alias.zsh

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
CURSOR_SIZE_LIGHT="${CURSOR_SIZE_LIGHT:-$DEFAULT_CURSOR_SIZE_LIGHT}"
CURSOR_DARK="${CURSOR_DARK:-$DEFAULT_CURSOR_DARK}"
CURSOR_SIZE_DARK="${CURSOR_SIZE_DARK:-$DEFAULT_CURSOR_SIZE_DARK}"
BACKGROUND_DARK="${BACKGROUND_DARK:-$DEFAULT_BACKGROUND_DARK}"
BACKGROUND_LIGHT="${BACKGROUND_LIGHT:-$DEFAULT_BACKGROUND_LIGHT}"
BRIGHTNESS_DARK="${BRIGHTNESS_DARK:-$DEFAULT_BRIGHTNESS_DARK}"
BRIGHTNESS_LIGHT="${BRIGHTNESS_LIGHT:-$DEFAULT_BRIGHTNESS_LIGHT}"

if [ "$1" = "dark" ]; then
  echo "dark mode"
  gsettings set org.gnome.desktop.interface color-scheme "'prefer-dark'"
  set-cursor-theme "$CURSOR_DARK" 
  set-cursor-size "$CURSOR_SIZE_DARK"
  gsettings set org.gnome.desktop.background picture-uri-dark "file://$BACKGROUND_DARK"
  sed -i "s/light/dark/" "$NVIM_FILE"
  brightnessctl s "$BRIGHTNESS_DARK%"
  notify-send "Dark mode"
fi

if [ "$1" = "light" ]; then
  echo "light mode"
  set-cursor-theme "$CURSOR_LIGHT" 
  set-cursor-size "$CURSOR_SIZE_LIGHT" 
  gsettings set org.gnome.desktop.background picture-uri "file://$BACKGROUND_LIGHT" &&
    sed -i "s/dark/light/" "$NVIM_FILE"
  gsettings set org.gnome.desktop.interface color-scheme "'prefer-light'"
  brightnessctl s "$BRIGHTNESS_LIGHT%"
  notify-send "Light mode"
fi
