#!/usr/bin/env fish 

waybar &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~/dotfiles/scripts/gsettings.fish &
# redshift -O 5500K & 
~/dotfiles/scripts/suspend.sh &
~/dotfiles/scripts/rofi-clipboard.fish &
xdman &
swaync &
# ~/dotfiles/scripts/rofi-beats-linux.py &
kitty --class=special
