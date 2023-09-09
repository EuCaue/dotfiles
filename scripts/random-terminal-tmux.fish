#!/usr/bin/env fish

set random_option $(math $(random) % 3)
set script $HOME/dotfiles/scripts/tmux-session.sh

switch $random_option
    case 0
        foot $script
    case 1
        kitty -e $script
    case 2
        alacritty -e $script
end
