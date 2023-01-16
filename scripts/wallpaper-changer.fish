#!/usr/bin/env fish
if test -z "$WALLPAPER"
    set WALLPAPER $(rofi -dmenu -p "Any wallpaper set, insert a path to one.: ") &
    swaybg -i $WALLPAPER -m fill
    echo $WALLPAPER >~/.config/wallpaper.txt
    return 0
end

set -x WALLPAPERBAK "$WALLPAPER" &&
    set -e -U WALLPAPER
set -Ux WALLPAPER $(find ~/Pictures/wallpapers -type f | shuf | rofi -i -dmenu -p "Wallpaper") &

if test -z "$WALLPAPER"
    set -Ux WALLPAPER $WALLPAPERBAK
    return 0
end

killall swaybg
swaybg -i $WALLPAPER -m fill
echo $WALLPAPER >~/.config/wallpaper.txt
return 1
