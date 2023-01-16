#!/usr/bin/env fish
set -e -U $CURSOR
set -e -U $CURSORSIZE

ls /usr/share/icons/ &&
    cd /usr/share/icons/ &&
    # read -S -P "Cursor theme: " CURSORTHEME
    set CURSORTHEME $(find -maxdepth 1 -type d | cut -d '/' -f 2 | sort | tail -n +2 | rofi -dmenu -i -p "Cursor theme" )
# read -Ux -P "Cursosr Size: " CURSORSIZE
set -Ux CURSORSIZE $(rofi -dmenu -p "Cursor Size")
set -Ux CURSOR $CURSORTHEME

echo $CURSOR
echo $CURSORSIZE

if test -z "$CURSOR"; or test "$CURSOR" = " "
    set CURSOR $XCURSOR_THEME
    return 1
end

echo "[Icon Theme]"\n"Inherits=$CURSOR" >~/.icons/default/index.theme
~/dotfiles/scripts/gsettings.fish
