#!/usr/bin/env fish
# wl-paste -p -t text --watch clipman store
wl-paste --watch cliphist store &
wl-paste --type image --watch cliphist store
