#!/usr/bin/env fish


set is_touch_pad_enabled $(hyprctl getoption device:syna3602:00-093a:0255-touchpad:enabled -j | jq .int)
printf "is_touch_pad_enabled: %s\n" $is_touch_pad_enabled

if test $is_touch_pad_enabled = 1 
    hyprctl keyword device:syna3602:00-093a:0255-touchpad:enabled false
    notify-send "Touchpad disabled"
else
    hyprctl keyword device:syna3602:00-093a:0255-touchpad:enabled true
    notify-send "Touchpad enabled"
end
