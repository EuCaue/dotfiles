#!/usr/bin/env sh

cd ~/AppImages/activitywatch || exit # Put your ActivityWatch install folder here

./aw-watcher-afk/aw-watcher-afk &
./aw-watcher-window/aw-watcher-window & # you can add --exclude-title here to exclude window title tracking for this session only
aw-watcher-media-player & 
notify-send "ActivityWatch started"     # Optional, sends a notification when ActivityWatch is started
./aw-server/aw-server
