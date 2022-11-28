#!/usr/bin/env fish 

set wall
set walltest false
set -x WAYLAND_DISPLAY wayland-0
set -x DISPLAY :1
set -x XDG_RUNTIME_DIR /run/user/1000

function wallpaperFind
    while test $walltest = false
        for file in $HOME/Pictures/wallpapers/*.{jpg, png}
            for number in (random 1 590)
                if test (random 1 590) = $number
                    set wall $file
                    return 1
                end
            end
        end
    end
    return 1
end

function wallpaperSet
    echo $wall >$HOME/.config/wallpaper.txt
    if test -n $(pgrep swaybg)
        killall swaybg
    end
    swaybg -i $wall -m fill
    return 1
end

wallpaperFind
wallpaperSet
