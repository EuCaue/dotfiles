#!/bin/fish

gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font" &&
gsettings set org.gnome.desktop.interface document-font-name "JetBrainsMono Nerd Font" &&
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrainsMono Nerd Font" &&
gsettings set org.gnome.desktop.interface cursor-theme Mocu-Black-Right &&
gsettings set org.gnome.desktop.interface icon-theme Rose-Pine &&
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark &&
gsettings set org.gnome.desktop.interface cursor-size 22 &&
hyprctl setcursor Mocu-Black-Right 22 &&
export XCURSOR_THEME=Mocu-Black-Right &&
export XCURSOR_SIZE=22
