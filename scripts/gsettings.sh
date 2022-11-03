#!/bin/fish

gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font" &&
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrainsMono Nerd Font" &&
gsettings set org.gnome.desktop.interface cursor-theme Win-8.1-S &&
gsettings set org.gnome.desktop.interface icon-theme Rose-Pine &&
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark &&
gsettings set org.gnome.desktop.interface cursor-size 16 &&
hyprctl setcursor Win-8.1-S 16 &&
export XCURSOR_THEME=Win-8.1-S &&
export XCURSOR_SIZE=16
