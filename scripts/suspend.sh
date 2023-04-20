#!/bin/bash 
swayidle -w \
      timeout 240 ' swaylock ' \
      timeout 400 ' hyprctl dispatch dpms off' \
              resume ' hyprctl dispatch dpms on'  \
      before-sleep 'swaylock'
