#!/bin/env fish

ls /usr/share/icons/ &&
    cd /usr/share/icons/ &&
    read -S -P "Cursor theme: " CURSORTHEME
read -x -P "Cursosr Size: " CURSORSIZE
set -x CURSOR $CURSORTHEME
echo $CURSOR
echo $CURSORSIZE
echo "[Icon Theme]"\n"Inherits=$CURSOR" >~/.icons/default/index.theme
~/dotfiles/scripts/gsettings.fish
