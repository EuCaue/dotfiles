#!/usr/bin/env fish 

swaybg -i $WALLPAPER -m fill &
waybar &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~/dotfiles/scripts/gsettings.fish &
~/dotfiles/scripts/suspend.sh &
~/dotfiles/scripts/rofi-clipboard.fish &
/opt/xdman/xdm-app &
redshift -O 5500K &
swaync &
sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
