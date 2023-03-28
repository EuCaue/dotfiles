#!/usr/bin/env fish 

~/dotfiles/scripts/gsettings.fish &
swaybg -i $WALLPAPER -m fill &
waybar &
mpv --volume="53" --title="radio-mpv" "https://www.youtube.com/watch?v=IjMESxJdWkg" --idle="yes" --input-ipc-server=/tmp/mpvsocket --no-video &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~/dotfiles/scripts/suspend.sh &
~/dotfiles/scripts/rofi-clipboard.fish &
redshift -O 5000K &
swaync &
sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
