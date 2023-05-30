#!/usr/bin/env fish
set -e -U $CURSOR
set -e -U $CURSORSIZE
set CURSORTHEME $(find /usr/share/icons -maxdepth 1 -type d | cut -d '/' -f 5 | sort | tail -n +2 | rofi -dmenu -i -p "Cursor theme" )

if test -z "$CURSORTHEME"; or test "$CURSORTHEME" = " "
    return 1
end

set -Ux CURSORSIZE $(rofi -dmenu -p "Cursor Size")
set -Ux CURSOR $CURSORTHEME

echo "[Icon Theme]"\n"Inherits=$CURSOR" >~/.icons/default/index.theme
~/dotfiles/scripts/gsettings.fish
