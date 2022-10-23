#!/bin/bash 
#  --debug notify-send "swayidle"
swayidle -w \
      timeout 300 ' swaylock -f -e -l -L -s fill -i ~/Pictures/wallpapers/rose_pine_maze.png' \
      timeout 400 ' hyprctl dispatch dpms off' \
              resume ' hyprctl dispatch dpms on'  
      before-sleep 'swaylock -f -e -l -L -s fill -i ~/Pictures/wallpapers/inxdex.jpg'


