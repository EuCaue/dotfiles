#!/bin/bash 
swayidle -w \
      timeout 120 ' swaylock ' \
      before-sleep 'swaylock'
