#!/bin/bash 
notify-send "lockscreen"
swayidle \
      timeout 1 ' swaylock -f -e -l -L -s fill -i ~/Pictures/wallpapers/rose_pine_maze.png' \
      timeout 2 ' hyprctl dispatch dpms off' \
              resume ' hyprctl dispatch dpms on && kill -S SIGINT ' \

              

