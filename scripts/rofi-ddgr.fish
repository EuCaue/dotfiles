#!/usr/bin/fish

function search_lofi
    set search $(rofi -dmenu -p "Search: " -theme-str 'listview {lines: 0;}')
    set -g result $(ddgr --json --num 20 --np --reg "br-pt" --site "www.youtube.com" "$search" | tee /tmp/search.tmp | jq '.[].title, .[].abstract' | rofi -dmenu -p "Choose: ")
    set -g url $(cat /tmp/search.tmp | jq -r ".[] | select(.title == $result) | .url")
    echo $url
    if test $status -ne 0
        return 1
    end
end

search_lofi
