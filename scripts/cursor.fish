#!/bin/env fish

set -x CURSOR $argv[1]
echo $CURSOR
echo "[Icon Theme]"\n"Inherits=$CURSOR" >~/.icons/default/index.theme
~/dotfiles/scripts/gsettings.fish
