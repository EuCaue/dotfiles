#!/usr/bin/env fish
set wp_dir "$HOME/Pictures/wallpapers"

function list_wps
    find "$wp_dir" -type f -printf "%P\n" | while read wp
        echo -en "$wp_dir/$wp\x00icon\x1f$wp_dir/$wp\n"
    end
end

if test -z "$WALLPAPER"
    set -Ux WALLPAPER $(list_wps | shuf | rofi -i -dmenu -p "Wallpaper" -theme-str '#entry { placeholder: "Wallpaper to apply.."; }') &
    swaybg -i $WALLPAPER -m fill
    echo $WALLPAPER >~/.config/wallpaper.txt
    return 0
end

set -x WALLPAPERBAK "$WALLPAPER" &&
    set -e -U WALLPAPER
set -Ux WALLPAPER $(list_wps | shuf | rofi -i -dmenu -p "Wallpaper" -theme-str '#entry { placeholder: "Wallpaper to apply.."; }') &

if test -z "$WALLPAPER"
    set -Ux WALLPAPER $WALLPAPERBAK
    echo $WALLPAPER >~/.config/wallpaper.txt
    return 0
end

swww img $WALLPAPER --transition-type grow --transition-pos "$(hyprctl cursorpos)" --transition-duration 1
echo $WALLPAPER >~/.config/wallpaper.txt
return 1
