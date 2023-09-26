#!/usr/bin/env fish

if test $argv[1] = up
    set -l volume $(pactl list sinks | grep -A 15 'RUNNING\|IDLE' | grep -m 1 'Volume:' | awk -F/ '{print $2}' | cut -d% -f1)
    if test $volume -gt 55 
        return
    else
        pactl set-sink-volume @DEFAULT_SINK@ +5%
    end
end

if test $argv[1] = down
    pactl set-sink-volume @DEFAULT_SINK@ -5%
end
