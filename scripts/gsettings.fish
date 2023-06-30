#!/usr/bin/env fish

if test -z "$CURSOR"; or test "$CURSOR" = " "
    set CURSOR $XCURSOR_THEME
end

if test -z "$CURSORSIZE"; or test "$CURSORSIZE" = " "
    set CURSORSIZE $XCURSOR_SIZE
end

echo $FONT_NAME

gsettings set org.gnome.desktop.interface cursor-theme $CURSOR &&
    gsettings set org.gnome.desktop.interface icon-theme Rowaita-Default-Dark &&
    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark &&
    gsettings set org.gnome.desktop.interface cursor-size $CURSORSIZE &&
    hyprctl setcursor $CURSOR $CURSORSIZE &&
    set -x XCURSOR_THEME $CURSOR &&
    set -x XCURSOR_SIZE $CURSORSIZE
