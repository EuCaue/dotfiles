#!/usr/bin/env fish

set search $(rofi -dmenu --prompt="Search: " --width=30 --lines=0)

set result $(ddgr --json $search | tee /tmp/search.tmp | jq '.[].title, .[].abstract' | rofi -dmenu) 

set url $(cat /tmp/search.tmp | jq -r ".[] | select(.title == $result) | .url")

firefox "$url"
