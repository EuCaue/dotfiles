#!/usr/bin/env fish

set FONT "JetBrainsMono Nerd Font 10"

if test -z "$CURSOR"; or test "$CURSOR" = " "
    set CURSOR $XCURSOR_THEME
end

if test -z "$CURSORSIZE"; or test "$CURSORSIZE" = " "
    set CURSORSIZE $XCURSOR_SIZE
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
