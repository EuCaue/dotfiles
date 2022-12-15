#!/bin/env fish

ls /usr/share/icons/ &&
    cd /usr/share/icons/ &&
    read -a -S -P "Cursor theme:" CURSORTHEME
set -x CURSOR $CURSORTHEME
echo $CURSOR
echo "[Icon Theme]"\n"Inherits=$CURSOR" >~/.icons/default/index.theme
~/dotfiles/scripts/gsettings.fish
