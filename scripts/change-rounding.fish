#!/usr/bin/env fish

set found_none false
set -e -U ROUNDING

if test $TERM = linux
    set -Ux ROUNDING $(rofi -dmenu -p "Set the rounding ")
else
    if test -z $argv[1]
        set -Ux ROUNDING 0
    else
        set -Ux ROUNDING $argv[1]
    end
end

for arg in $argv
    if test "$arg" = --none
        set found_none true
        break
    end
end

function verify_status_bar
    if pgrep waybar
        killall waybar && waybar & disown &
    end

    if pgrep ags
        killall ags && ags & disown &
    end
end

function change_rouding
    set -l default_border_size 3

    sed -i "s#\(border-radius: \).*#\1"$ROUNDING"px;#" $HOME/.config/ags/style.css
    sed -i "s#\(border-top: \).*#\1"$default_border_size"px solid @accent_color;#" $HOME/.config/ags/style.css
    sed -i "s#\(border-bottom: \).*#\1"$default_border_size"px solid @accent_color;#" $HOME/.config/ags/style.css

    sed -i "s#\(border-radius: \).*#\1"$ROUNDING"px;#" $HOME/dotfiles/dotconfig/waybar/style.css
    sed -i "s#\(border-top: \).*#\1"$default_border_size"px solid @accent_color;#" $HOME/dotfiles/dotconfig/waybar/style.css
    sed -i "s#\(border-bottom: \).*#\1"$default_border_size"px solid @accent_color;#" $HOME/dotfiles/dotconfig/waybar/style.css

    verify_status_bar
    sed -i "s#\(border-radius: \).*#\1"$ROUNDING";#" $HOME/dotfiles/dotconfig/rofi/config.rasi
    sed -i '/\.notification-default-action {/ {n; s#border-radius: .*;#border-radius: '"$ROUNDING"px';#}' $HOME/dotfiles/dotconfig/swaync/style.css &&
        swaync-client -rs
    sed -i 's/\(rounding = \)[0-9]\+/\1'"$ROUNDING"'/' $HOME/dotfiles/dotconfig/hypr/hyprland.conf
    sed -i 's/\(border_size = \)[0-9]\+/\1'"$default_border_size"'/' $HOME/dotfiles/dotconfig/hypr/hyprland.conf

    if $found_none
        sed -i 's/M\.border_status = "[^"]*"/M\.border_status = "none"/' /home/caue/dotfiles/dotconfig/nvim/lua/user/utils/init.lua
        sed -i 's/\(border_size = \)[0-9]\+/\1'"$ROUNDING"'/' $HOME/dotfiles/dotconfig/hypr/hyprland.conf
        sed -i "s#\(border-top: \).*#\1"0"px;#" $HOME/dotfiles/dotconfig/waybar/style.css
        sed -i "s#\(border-bottom: \).*#\1"0"px;#" $HOME/dotfiles/dotconfig/waybar/style.css

        sed -i "s#\(border-top: \).*#\1"0"px;#" $HOME/.config/ags/style.css 
        sed -i "s#\(border-bottom: \).*#\1"0"px;#" $HOME/.config/ags/style.css 
    else if test $ROUNDING -gt 10
        sed -i 's/M\.border_status = "[^"]*"/M\.border_status = "rounded"/' /home/caue/dotfiles/dotconfig/nvim/lua/user/utils/init.lua
    else
        sed -i 's/M\.border_status = "[^"]*"/M\.border_status = "single"/' /home/caue/dotfiles/dotconfig/nvim/lua/user/utils/init.lua
    end
end

change_rouding
