#!/usr/bin/env fish
set -e -U $CURSOR
set -e -U $CURSORSIZE

ls /usr/share/icons/ &&
    set CURSORTHEME $(find /usr/share/icons -maxdepth 1 -type d | cut -d '/' -f 5 | sort | tail -n +2 | rofi -dmenu -i -p "Cursor theme" )
set -Ux CURSORSIZE $(rofi -dmenu -p "Cursor Size")
set -Ux CURSOR $CURSORTHEME

# notify-send $CURSOR
# echo $CURSORSIZE

if test -z "$CURSOR"; or test "$CURSOR" = " "
    set CURSOR $XCURSOR_THEME
    return 1
end

echo "[Icon Theme]"\n"Inherits=$CURSOR" >~/.icons/default/index.theme
~/dotfiles/scripts/gsettings.fish
