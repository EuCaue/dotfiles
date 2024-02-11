#!/usr/bin/env fish

set -l volume 40
set command_to_run pactl set-sink-volume @DEFAULT_SINK@ $volume%
set default_sink $(pactl info | grep 'Default Sink' | awk '{print $3}')
set volume $(pactl list sinks | grep -A 7 "$default_sink" | awk '/Volume:/{print $5}' |cut -d% -f1)

if test $argv[1] = up
    echo $volume
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
    echo "{ \"command\": [\"set_property\", \"volume\", 35] }" | socat - $mpv_socket
else
    mpv --script-opts=ytdl_hook-ytdl_path=yt-dlp --volume=30 --title="radio-mpv" "https://live.hunter.fm/lofi_high" --input-ipc-server=/tmp/mpvsocket --no-video --idle=once &
end

if test $volume -lt $volume
    return 0
end

$command_to_run
