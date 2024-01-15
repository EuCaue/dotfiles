#!/usr/bin/env fish

set -l volume 40
set command_to_run pactl set-sink-volume @DEFAULT_SINK@ $volume%
#  TODO:socket? 
set volume $(pactl list sinks | grep 'Volume:' | head -n 1 | awk -F/ '{print $2}' | cut -d% -f1)

if test $argv[1] = up
    if test $volume -gt 55
        return 0
    else
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        return 0
    end
end

if test $argv[1] = down
    pactl set-sink-volume @DEFAULT_SINK@ -5%
    return 0
end

if pgrep -f radio-mpv
    set mpv_socket /tmp/mpvsocket
    set pause_status (echo '{ "command": ["get_property", "pause"] }' | socat - $mpv_socket)
    if string match -q -r true (echo $pause_status)
        echo '{ "command": ["cycle", "pause"] }' | socat - $mpv_socket
    end
    echo "{ \"command\": [\"set_property\", \"volume\", 30] }" | socat - $mpv_socket
else
    mpv --script-opts=ytdl_hook-ytdl_path=yt-dlp --volume=30 --title="radio-mpv" "https://play.streamafrica.net/lofiradio" --input-ipc-server=/tmp/mpvsocket --no-video --idle=once &
end

if test $volume -lt $volume
    return 0
end

$command_to_run
