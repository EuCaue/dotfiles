#!/usr/bin/env fish

set found_none false
set -e -U ROUNDING

if test $TERM = linux
    set -Ux ROUNDING $(rofi -dmenu -p "Set the rounding")
else
    if test -z $argv[1]
        set -Ux ROUNDING 0
    else
        set -Ux ROUNDING $argv[1]
    end
end

for arg in $argv
    echo $arg
    if test "$arg" = --none
        set found_none true
        break
    end
end

function change_rouding
    sed -i "s#\(border-radius: \).*#\1"$ROUNDING"px;#" $HOME/dotfiles/dotconfig/waybar/style.css
    killall waybar && waybar & disown &
    sed -i "s#\(border-radius: \).*#\1"$ROUNDING";#" $HOME/dotfiles/dotconfig/rofi/config.rasi
    sed -i 's/\(rounding = \)[0-9]\+/\1'"$ROUNDING"'/' $HOME/dotfiles/dotconfig/hypr/hyprland.conf

    if $found_none
        sed -i 's/M\.border_status = "[^"]*"/M\.border_status = "none"/' /home/caue/dotfiles/dotconfig/nvim/lua/user/utils/init.lua
        sed -i 's/\(border_size = \)[0-9]\+/\1'"$ROUNDING"'/' $HOME/dotfiles/dotconfig/hypr/hyprland.conf
    else if test $ROUNDING -gt 10
        sed -i 's/M\.border_status = "[^"]*"/M\.border_status = "rounded"/' /home/caue/dotfiles/dotconfig/nvim/lua/user/utils/init.lua
    else
        sed -i 's/M\.border_status = "[^"]*"/M\.border_status = "single"/' /home/caue/dotfiles/dotconfig/nvim/lua/user/utils/init.lua
    end
end

change_rouding
