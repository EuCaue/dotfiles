#!/usr/bin/env fish

set options exit hyprland\nreboot\npoweroff

set option $(echo $options | rofi -dmenu -p "Select:") &&
    echo $option &


switch $option
    case 'exit hyprland'
        notify-send "Poweroff Menu" "exiting hyprland..." &&
            hyprctl dispatch exit

    case poweroff
        notify-send "Poweroff Menu" "powering off in 2s." &&
            sleep 2 &&
            shutdown now

    case reboot
        notify-send "Poweroff Menu" "reboting in 2s" &&
            sleep 2 &&
            reboot
end
