#!/usr/bin/fish
set option1 " Print: 1"\n
set option2 "Record: 2"\n
set option3 "Stop Recording: 3" 
set o $option1 $option2 $option3

set mode $(echo $o | rofi -dmenu -p "Select") &&
echo $mode & 

switch $mode 
    
    case ' Print: 1'
          echo "a" &
          grim -g "$(slurp -d)" - | swappy -f - 
    
    case ' Record: 2'
          echo "b" &
          notify-send "Recording" && wf-recorder -g "$(slurp -d)" -a -f ~/Videos/Screencasts/"$(date +'Screencast from %Y-%m-%d %H:%M:%S.mp4')"  

    case ' Stop Recording: 3'
          echo "c" &      
          killall -s SIGINT wf-recorder & notify-send "Stop Recording"
end
