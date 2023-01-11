#!/usr/bin/env fish

set FONT "JetBrainsMono Nerd Font 10"

if test -z $CURSOR
    set CURSOR $XCURSOR_THEME
end

if test -z $CURSORSIZE
    set CURSORSIZE 24
end

gsettings set org.gnome.desktop.interface font-name $FONT &&
    gsettings set org.gnome.desktop.interface document-font-name $FONT &&
    gsettings set org.gnome.desktop.interface monospace-font-name $FONT &&
    gsettings set org.gnome.desktop.interface cursor-theme $CURSOR &&
    gsettings set org.gnome.desktop.interface icon-theme Rose-Pine &&
    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark &&
    gsettings set org.gnome.desktop.interface cursor-size $CURSORSIZE &&
    hyprctl setcursor $CURSOR $CURSORSIZE &&
    set -x XCURSOR_THEME $CURSOR &&
    set -x XCURSOR_SIZE $CURSORSIZE 
