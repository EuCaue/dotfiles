#!/usr/bin/env fish 

waybar &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~/dotfiles/scripts/gsettings.fish &
~/dotfiles/scripts/suspend.sh &
~/dotfiles/scripts/rofi-clipboard.fish &
xdman &
swaync &
