#!/bin/env fish

set -Ux CURSOR $argv[1]
echo $CURSOR
echo "[Icon Theme]"\n "Inherits=$CURSOR" > ~/.icons/default/index.theme
~/dotfiles/scripts/gsettings.fish
