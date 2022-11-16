#!/bin/fish 

waybar & 
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~/dotfiles/scripts/gsettings.sh &
redshift -O 5500K & 
~/dotfiles/scripts/suspend.sh &
~/dotfiles/scripts/rofi-clipboard.sh &
xdman &
swaync &
~/dotfiles/scripts/rofi-beats-linux.py &
kitty --class=special 
