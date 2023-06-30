#!/usr/bin/env fish


function notification
    # change the icon to whatever you want. Make sure your notification server 
    # supports it and already configured.

    # Now it will receive argument so the user can rename the radio title
    # to whatever they want
    notify-send "Playing now: " $argv[1] --icon=media-tape
end

function menu
    echo "1. Lofi Girl"
    echo "2. Lofi Hunter"
    echo "3. Lofi HipHop"
    echo "4. Chillhop"
    echo "5. Box Lofi"
    echo "6. Coffee Shop Lofi"
    echo "7. Rainy Nights"
    echo "8. SmoothChill"
    echo "9. Lofi TokyoGhoul"
    echo "10. Cloudy Sakura"
    echo "11. Rain Sounds"
    echo "12. Nature Sounds"
    echo "13. Code Lofi"
end

function menu_pause
    echo "1. Return"
    echo "2. Stop"
    echo "3. Change Volume"
    echo "4. Nothing"
    echo "5. Change Radio"
end

function menu_running
    echo "1. Pause"
    echo "2. Stop"
    echo "3. Change Volume"
    echo "4. Nothing"
    echo "5. Change Radio"
end

function is_running
    set mpv_socket /tmp/mpvsocket
    set pause_status (echo '{ "command": ["get_property", "pause"] }' | socat - $mpv_socket)


    if pgrep -f radio-mpv
        echo "is running"
        if string match -q -r true (echo $pause_status)
            set choice_menu_pause $(menu_pause | rofi -dmenu -p "Paused, Return/Stop/Nothing?" | cut -d. -f1)
            switch $choice_menu_pause
                case 1
                    echo '{ "command": ["cycle", "pause"] }' | socat - $mpv_socket
                case 2
                    pkill -f radio-mpv
                case 3
                    set volume $(rofi -dmenu -p "Volume" -theme-str 'listview {lines: 0;}')
                    echo "{ \"command\": [\"set_property\", \"volume\", $volume] }" | socat - $mpv_socket
                case 4
                    echo ":)"
                case 5
                    pkill -f radio-mpv &&
                        main

            end
        else
            set choice_menu_running $(menu_running | rofi -dmenu -p "Playing, Stop/Pause/Nothing" | cut -d. -f1)
            switch $choice_menu_running
                case 1
                    echo '{ "command": ["cycle", "pause"] }' | socat - $mpv_socket
                case 2
                    pkill -f radio-mpv
                case 3
                    set volume $(rofi -dmenu -p "Volume" -theme-str 'listview {lines: 0;}')
                    echo "{ \"command\": [\"set_property\", \"volume\", $volume] }" | socat - $mpv_socket
                case 4
                    echo ":)"
                case 5
                    pkill -f radio-mpv &&
                        main
            end
        end
        return 0
    end
    return 1
end


function main
    is_running
    if test $status -eq 0
        return 1
    end

    set choice $(menu | rofi -dmenu -p "Station" | cut -d. -f1)
    if test -z $choice
        return 1
    end
    set volume $(rofi -dmenu -p "Volume")

    switch $choice
        case 1
            notification "Lofi Girl ☕️🎶"
            set URL "https://play.streamafrica.net/lofiradio"
        case 2
            notification "Lofi Hunter ☕️🎶"
            set URL "https://live.hunter.fm/lofi_high"
        case 3
            notification "Lofi HipHop ☕️🎶"
            set URL "http://hyades.shoutca.st:8043/stream"
        case 4
            notification "Chillhop ☕️🎶"
            set URL "http://stream.zeno.fm/fyn8eh3h5f8uv"
        case 5
            notification "Box Lofi ☕️🎶"
            set URL "http://stream.zeno.fm/f3wvbbqmdg8uv"
        case 6
            notification "Coffee Shop Lofi ☕️🎶"
            set URL "https://www.youtube.com/watch?v=lP26UCnoH9s"
        case 7
            notification "Rainy Nights ☕️🎶"
            set URL "https://www.youtube.com/watch?v=DGTZbDBRfNg"
        case 8
            notification "SmoothChill ☕️🎶"
            set URL "https://media-ssl.musicradio.com/SmoothChill"
        case 9
            notification "Lofi TokyoGhoul ☕️🎶"
            set URL "https://youtube.com/playlist?list=PL3Xsq8k7CYjMPh-F15n0ClL14jEBr6S37"
        case 10
            notification "Lofi Cloudy Sakura ☕️🎶"
            set URL "https://www.youtube.com/watch?v=IjMESxJdWkg"
        case 11
            notification "Rain Sounds ☕️🎶"
            set URL "https://www.youtube.com/watch?v=Jvgx5HHJ0qw"
        case 12
            notification "Nature Sounds ☕️🎶"
            set URL "https://www.youtube.com/watch?v=qRTVg8HHzUo"
        case 13
            notification "Code Lofi ☕️🎶"
            set URL "https://www.youtube.com/watch?v=SigIbCVMTzU"
    end
    mpv --volume=$volume --title="radio-mpv" $URL --input-ipc-server=/tmp/mpvsocket --no-video
end

main
