#!/usr/bin/env fish

set script $( find ~/dotfiles/scripts/ -type f -name "*" -exec basename {} \; | sort | rofi -dmenu )
~/dotfiles/scripts/$script
