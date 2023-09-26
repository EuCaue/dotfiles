#!/usr/bin/env fish

function menu_calc
    echo "1. Copy to clipboard"
    echo "2. Clear"
    echo "3. Close"
end

function main
    set input (fuzzel --dmenu0 --lines 0 --prompt "Calc: ")
    set result (qalc -t "$input")
    set ans (menu_calc | fuzzel --dmenu --lines 3 --prompt "$result " | cut -d. -f1)

    switch $ans
        case 1
            wl-copy $result
        case 2
            main
        case 3
            exit
    end
end

main
