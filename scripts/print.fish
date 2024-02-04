#!/usr/bin/env fish


function menu_options
    echo "1. Print Screen"
    echo "2. Print Area"
    echo "3. Print Window"
end

function print_screen
    sleep 0.5 &&
        grim -c - | swappy -f -
end

function get_geometry
    freeze
    slurp -b "#00000000" -s "#FFFFFF25" -c "#FFFFFFFF" -w 2 -d -F "$(echo $FONT_NAME)" &&
        sleep 0.12 &&
        killall hyprpicker

end

function freeze
    hyprpicker -r -z &
    sleep 0.2
end

function print_area
    freeze
    set geo $(slurp -b "#00000000" -s "#FFFFFF25" -c "#FFFFFFFF" -w 2 -d -F "$(echo $FONT_NAME)") && sleep 0.39
    grim -c -g $geo - | swappy -f -
end

function print_window
    set hyprvars (hyprctl activewindow -j | cut -d' ' -f2- | head -n -1 | tail -n +4)
    set jqvars (echo -e "{\n$hyprvars\n}" | jq -r ".at,.size" | jq -s "add" | jq '_nwise(4)' | jq -r '"\(.[0]),\(.[1]) \(.[2])x\(.[3])"')
    sleep 0.5 &&
        grim -c -g "$jqvars" - | swappy -f -
end

switch $argv[1]
    case screen
        print_screen
        return 1
    case area
        print_area
        return 1
    case window
        print_window
        return 1
    case geo
        get_geometry
        return 1
end

set choice_print $(menu_options | rofi -dmenu -p "Print mode: " -theme-str 'listview {lines: 3;}' | cut -d. -f1 )

switch $choice_print
    case 1
        print_screen

    case 2
        print_area

    case 3
        print_window
end
