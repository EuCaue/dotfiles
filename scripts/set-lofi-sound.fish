#!/usr/bin/env fish

function set_volume -a VOL
    echo $VOL
    set mpv_socket /tmp/mpvsocket
    echo "{ \"command\": [\"set_property\", \"volume\", "$VOL"] }" | socat - $mpv_socket
end

#  TODO: adding a check for it's volume it's current set to this correct value, return; 
function main 
    pactl subscribe | while read -l line
        echo $line | grep -q change
        if test $status -eq 0
            set volume $(pactl list sinks | grep -E "^\s+Volume:" | awk '{print $12}' | cut -d% -f1)
            if test $volume -ge 0; and test $volume -lt 60
                set_volume 50
            else if test $volume -ge 60
                set_volume 40
            end
        end
    end
end

main
