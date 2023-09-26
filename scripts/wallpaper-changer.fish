#!/usr/bin/env fish
set wp_dir "$HOME/Pictures/wallpapers"

function list_wps
    fd --type f --threads 4 --base-directory "$wp_dir" | while read wp
        set file_path "$wp_dir/$wp"
        set formatted_output "$file_path\x00icon\x1f$file_path"
        echo -en $formatted_output"\n"
    end
end

if test -z "$WALLPAPER"
set -Ux WALLPAPER (list_wps | shuf | parallel -j4 --pipe rofi -dmenu -p "Wallpaper" -theme-str '#entry { placeholder: "Wallpaper to apply.."; }' ) &
    swww img $WALLPAPER --transition-type grow --transition-pos "$(hyprctl cursorpos)" --transition-duration 1
    echo $WALLPAPER >~/.config/wallpaper.txt
    return 0
end

set -x WALLPAPERBAK "$WALLPAPER" &&
    set -e -U WALLPAPER
set -Ux WALLPAPER (list_wps | shuf | parallel -j4 --pipe rofi -dmenu -p "Wallpaper" -theme-str '#entry { placeholder: "Wallpaper to apply.."; }' ) &

if test -z "$WALLPAPER"
    set -Ux WALLPAPER $WALLPAPERBAK
    echo $WALLPAPER >~/.config/wallpaper.txt
    return 0
end

swww img $WALLPAPER --transition-type grow --transition-pos "$(hyprctl cursorpos)" --transition-duration 1
echo $WALLPAPER >~/.config/wallpaper.txt
return 1
