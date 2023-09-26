#!/usr/bin/env fish

set script $( find ~/dotfiles/scripts/ -type f -name "*" -exec basename {} \; | sort | fuzzel --dmenu )
~/dotfiles/scripts/$script
