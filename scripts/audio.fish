#!/usr/bin/env fish

set device_mac "6D:01:01:1A:AB:44"
set command_to_run_bluetooth pactl set-sink-volume @DEFAULT_SINK@ 50%
set command_to_run pactl set-sink-volume @DEFAULT_SINK@ 60%
set device_info (bluetoothctl info $device_mac)
set is_connected (echo $device_info | grep "Connected: yes")
if test -n "$is_connected"
    $command_to_run_bluetooth
else
    $command_to_run
end
killall mpv &&
mpv --volume="60" --title="radio-mpv" "https://www.youtube.com/watch?v=IjMESxJdWkg" --idle="yes" --input-ipc-server=/tmp/mpvsocket --no-video
