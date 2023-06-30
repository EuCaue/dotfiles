#!/usr/bin/env fish 

~/dotfiles/scripts/gsettings.fish &
swaybg -i $WALLPAPER -m fill &
waybar &
/opt/xdman/xdm-app &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~/dotfiles/scripts/suspend.sh &
~/dotfiles/scripts/rofi-clipboard.fish &
redshift -O 5000K &
swaync &
~/dotfiles/scripts/rofi-lofi.fish &
sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
