#!/usr/bin/env fish

set options exit hyprland\nreboot\npoweroff

set option $(echo $options | rofi -dmenu -p "Select:") &&
    echo $option &
set seconds 5

switch $option
    case 'exit hyprland'
        notify-send "Poweroff Menu" "exiting hyprland..." &&
            hyprctl dispatch exit

    case poweroff
        notify-send "Poweroff Menu" "powering off in $seconds\s." &&
            sleep 2 &&
            shutdown now

    case reboot
        notify-send "Poweroff Menu" "reboting in $seconds\s" &&
            sleep 2 &&
            reboot
end
