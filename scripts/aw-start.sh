#!/usr/bin/env sh

cd ~/AppImages/activitywatch || exit

# ./aw-watcher-afk/aw-watcher-afk &
# ./aw-watcher-window/aw-watcher-window &
aw-awatcher &
aw-watcher-media-player &
notify-send "ActivityWatch started"
./aw-server/aw-server
