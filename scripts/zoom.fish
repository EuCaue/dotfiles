#!/usr/bin/env fish

set zoom_value $(hyprctl getoption misc:cursor_zoom_factor -j | jq -r '.float')
set scale_factor_default 1
set scale_factor 0.1

if test $argv[1] = default 
    hyprctl keyword misc:cursor_zoom_factor $scale_factor_default
end

if test $argv[1] = plus
    if test $zoom_value -gt "5.0"
        echo "highest zoom"
        return 0
    end
    hyprctl keyword misc:cursor_zoom_factor $( math $zoom_value + $scale_factor)
end

if test $argv[1] = minus
    if test $zoom_value -eq "1.0"
        echo "lowest zoom"
        return 0
    end
    hyprctl keyword misc:cursor_zoom_factor $( math $zoom_value - $scale_factor)
end
