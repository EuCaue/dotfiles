#!/usr/bin/env fish

set device_mac "6D:01:01:1A:AB:44"
set command_to_run_bluetooth pactl set-sink-volume @DEFAULT_SINK@ 50%
set command_to_run pactl set-sink-volume @DEFAULT_SINK@ 60%
set device_info (bluetoothctl info $device_mac)
set is_connected (echo $device_info | grep "Connected: yes")
set volume $(pactl list sinks | grep 'Volume:' | head -n 1 | awk -F/ '{print $2}' | cut -d% -f1)

if test $volume -lt 60
    return 0
end


if test -n "$is_connected"
    $command_to_run_bluetooth
else
    $command_to_run
end
