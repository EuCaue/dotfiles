#!/bin/bash 
swayidle -w \
      timeout 100 ' swaylock ' \
      # timeout 400 ' hyprctl dispatch dpms off' \
              # resume ' hyprctl dispatch dpms on'  \
      # before-sleep 'swaylock -f -e -l -L -s fill -i ~/Pictures/wallpapers/inxdex.jpg'
