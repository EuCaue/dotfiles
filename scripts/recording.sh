#!/bin/sh

menu_start_recording() {
echo "1: Record"  
echo "2: Record Area"
echo "3: Stop recording"
echo "4: Leave"
}

choice_start_recording=$(menu_start_recording | rofi -dmenu -p "Choose a option." | cut -d: -f1)

case $choice_start_recording in 
  1)
  wl-screenrec --codec hevc --encode-pixfmt vuyx --audio -f ~/Videos/Screencasts/"$(date +'Screencast from %Y-%m-%d %H:%M:%S.mp4')"

  notify-send "Start Recording 🚀🚀"
    ;;
  2)
  wl-screenrec --codec hevc --encode-pixfmt vuyx --audio -g "$(slurp -d)" -f ~/Videos/Screencasts/"$(date +'Screencast from %Y-%m-%d %H:%M:%S.mp4')"
  notify-send "Start Recording 🚀🚀"
    ;;
  3)
    killall wl-screenrec && 
      notify-send "Stopped Recording 🚀🚀"
    ;;
  4)
    notify-send "Nothing to do here. ☮"
    ;;

  esac
