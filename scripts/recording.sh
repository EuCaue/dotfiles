#!/bin/sh

menu_start_recording() {
echo "1: Record"  
echo "2: Record Area"
echo "3: Quit"
}

choice_start_recording=$(menu_start_recording | rofi -dmenu -p "bomdia" | cut -d: -f1)

echo $choice_start_recording

case $choice_start_recording in 
  1)
wf-recorder --audio -f ~/Videos/Screencasts/"$(date +'Screencast from %Y-%m-%d %H:%M:%S.mp4')"
    ;;
  2)
wf-recorder -g "$(slurp -d)" --audio -f ~/Videos/Screencasts/"$(date +'Screencast from %Y-%m-%d %H:%M:%S.mp4')"
    ;;
  3)
    ;;
  esac
