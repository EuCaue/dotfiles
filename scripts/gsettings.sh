#!/bin/fish

gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font" &&
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrainsMono Nerd Font" &&
gsettings set org.gnome.desktop.interface cursor-theme macOS-BigSur &&
gsettings set org.gnome.desktop.interface icon-theme Rose-Pine &&
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark &&
gsettings set org.gnome.desktop.interface cursor-size 22 &&
hyprctl setcursor macOS-BigSur 22 &&
export XCURSOR_THEME=macOS-BigSur &&
export XCURSOR_SIZE=22
