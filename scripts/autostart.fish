#!/usr/bin/env fish 

~/dotfiles/scripts/gsettings.fish &
swww init &
sleep 1 &&
    swww img $WALLPAPER --transition-type grow --transition-pos "$(hyprctl cursorpos)" --transition-duration 1
ags &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~/dotfiles/scripts/suspend.sh &
~/dotfiles/scripts/rofi-clipboard.fish &
redshift -O 3500K &
swaync &
/opt/xdman/xdm-app &
# hyprshade on vibrance &
syncthing -no-browser
