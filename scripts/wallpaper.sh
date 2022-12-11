#!/bin/sh 

export wall=
export walltest=false 
export WAYLAND_DISPLAY=wayland-1
export DISPLAY=:1 
export XDG_RUNTINE_DIR=/run/user/1000

wallpaperFind() {
  while [ $walltest == false ]
  do 
    for file in $HOME/Pictures/wallpapers/*
    do 
      if [ $((1 + SRANDOM % 600)) == $((1 + SRANDOM % 600)) ]; then 
        wall=$file  
        return 1
      fi 
    done 
    done
}

wallpaperSet() {
    echo $wall > $HOME/.config/wallpaper.txt
    killall swaybg
    swaybg -i $wall -m fill 
    return 1
}

wallpaperFind
wallpaperSet
