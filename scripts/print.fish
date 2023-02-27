#!/usr/bin/env fish
set option1 " Print: 1"\n
set option2 "Record: 2"\n
set option3 "Record screen: 3"\n
set option4 "Stop Recording: 4"
set o $option1 $option2 $option3 $option4

set mode $(echo $o | rofi -dmenu -p "Select") &&
    echo $mode &

switch $mode

    case ' Print: 1'
        echo a &
        grim -g "$(slurp -d)" - | swappy -f -

    case ' Record: 2'
        echo b &
        notify-send Recording && wf-recorder -g "$(slurp -d)" -a -f ~/Videos/Screencasts/"$(date +'Screencast from %Y-%m-%d %H:%M:%S.mp4')"

    case ' Record screen: 3'
        echo b &
        notify-send Recording && wf-recorder -a -f ~/Videos/Screencasts/"$(date +'Screencast from %Y-%m-%d %H:%M:%S.mp4')"

    case ' Stop Recording: 4'
        echo c &
        killall -s SIGINT wf-recorder & notify-send "Stop Recording"
end
