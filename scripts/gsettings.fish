#!/bin/fish

gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font" &&
    gsettings set org.gnome.desktop.interface document-font-name "JetBrainsMono Nerd Font" &&
    gsettings set org.gnome.desktop.interface monospace-font-name "JetBrainsMono Nerd Font" &&
    gsettings set org.gnome.desktop.interface cursor-theme $CURSOR &&
    gsettings set org.gnome.desktop.interface icon-theme Rose-Pine &&
    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark &&
    gsettings set org.gnome.desktop.interface cursor-size 24 &&
    hyprctl setcursor $CURSOR 24 &&
    export XCURSOR_THEME=$CURSOR &&
    export XCURSOR_SIZE=24
