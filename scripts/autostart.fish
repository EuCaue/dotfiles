#!/usr/bin/env fish 

~/dotfiles/scripts/gsettings.fish &
swww init &
sleep 1 &&
    swww img $WALLPAPER --transition-type grow --transition-pos "$(hyprctl cursorpos)" --transition-duration 1
ags --config $HOME/.config/ags/appbar/config.js &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~/dotfiles/scripts/suspend.sh &
~/dotfiles/scripts/rofi-clipboard.fish &
redshift -O 3500K &
swaync &
# mako &
# dunst &
/opt/xdman/xdm-app &
mpv --script-opts=ytdl_hook-ytdl_path=yt-dlp --volume=30 --title="radio-mpv" "https://live.hunter.fm/lofi_high" --input-ipc-server=/tmp/mpvsocket --no-video --idle=once &
~/dotfiles/scripts/set-lofi-sound.fish
# syncthing -no-browser
