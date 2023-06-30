#!/bin/bash 
swayidle -w \
      timeout 240 " fish -c 'gtklock -b $WALLPAPER ' " \
      timeout 400 ' hyprctl dispatch dpms off' \
              resume ' hyprctl dispatch dpms on'  \
      # before-sleep " fish -c 'gtklock -b $WALLPAPER ' "
