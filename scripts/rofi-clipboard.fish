#!/usr/bin/env fish
wl-paste --watch cliphist -max-items 2000 store &
wl-paste --type image --watch cliphist store
