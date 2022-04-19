#!/usr/bin/fish

function set_onedark_color -a name rgb index256 -d "define color for onedark"
    function __set_onedark_color_help
        echo "Name: set_onedark_color - Define color for onedark"
        echo
        echo "Usage:"
        echo "    set_onedark_color COLOR RGB-HEX INDEX-256"
        echo "    set_onedark_color [-h|--help]"
        echo
        echo "Arguments:"
        echo "    COLOR"
        echo "        Target color name that can use builtin 'set_color'."
        echo "        (Ex: black green brmagenta brwhite ...)"
        echo "    RGB-HEX"
        echo "        24bit RGB color code, like 'a3ff00', '0C060F'."
        echo "        It can use full size only, cannot use short style like '88D'."
        echo "        If you want not to change value, then set 'current',"
        echo "        or you want to use preset value, then set 'default'."
        echo "    INDEX-256"
        echo "        Index of 256 color, in the range from 16 to 255."
        echo "        If you want not to change value, then set 'current',"
        echo "        or you want to use preset value, then set 'default'."
        echo
        echo "Examples:"
        echo "    Define custom black color:"
        echo '            $ set_onedark_color black 0a0400 231'
        echo
        echo "    Overwrite only white 256 color index:"
        echo '            $ set_onedark_color white current 255'
    end

    # check help options
    while count $argv > /dev/null
        switch $argv[1]; case -h --help
            __set_onedark_color_help
            return
        end
        set -e argv[1]
    end

    # validate each arguments
    set -l target
    set -l color
    set -l current_color
    set -l default_color
    if test -z "$name"
        return 1
    else
        switch $name
            case black;     set default_color 282c34 235 0
            case red;       set default_color be5046 196 1
            case green;     set default_color 699959 71  2
            case yellow;    set default_color d19a66 173 3
            case blue;      set default_color 2e6399 25  4
            case magenta;   set default_color 9918a6 90  5
            case cyan;      set default_color 23878c 30  6
            case white;     set default_color abb2bf 145 7
            case brblack;   set default_color 5c6370 59  8
            case brred;     set default_color e06c75 204 9
            case brgreen;   set default_color 98c379 114 10
            case bryellow;  set default_color e5c07b 180 11
            case brblue;    set default_color 61afef 39  12
            case brmagenta; set default_color c678dd 170 13
            case brcyan;    set default_color 56b6c2 38  14
            case brwhite;   set default_color cfd7e6 253 15
            case "*"
                echo "set_onedark_color: Unknown color '$name' at index 1" > /dev/stderr
                return 1
        end

        set target "__onedark_$name"
        if test (set -q $target; echo $status) -ne 0
            switch $name
                case black red green yellow blue magenta cyan white brblack brred brgreen bryellow brblue brmagenta brcyan brwhite
                    set -g __onedark_$name $default_color
                case "*"
                    echo "set_onedark_color: Unknown color '$name' at index 1" > /dev/stderr
                    return 1
            end
        end
        switch $name
            case black;     set current_color $__onedark_black
            case red;       set current_color $__onedark_red
            case green;     set current_color $__onedark_green
            case yellow;    set current_color $__onedark_yallow
            case blue;      set current_color $__onedark_blue
            case magenta;   set current_color $__onedark_magenta
            case cyan;      set current_color $__onedark_cyan
            case white;     set current_color $__onedark_white
            case brblack;   set current_color $__onedark_brblack
            case brred;     set current_color $__onedark_brred
            case brgreen;   set current_color $__onedark_brgreen
            case bryellow;  set current_color $__onedark_bryallow
            case brblue;    set current_color $__onedark_brblue
            case brmagenta; set current_color $__onedark_brmagenta
            case brcyan;    set current_color $__onedark_brcyan
            case brwhite;   set current_color $__onedark_brwhite
            case "*"
                echo "set_onedark_color: Unknown color '$name' at index 1" > /dev/stderr
                return 1
        end
    end

    if test "$rgb" = "current"
        set rgb $current_color[1]
    else if test "$rgb" = "default"
        set rgb $default_color[1]
    else if string match -iqrv '^[0-9a-f]{6}$' $rgb
        echo "set_onedark_color: Cannot use '$rgb' at index 2" > /dev/stderr
        return 2
    end

    if test "$index256" = "current"
        set index256 $current_color[2]
    else if test "$index256" = "default"
        set index256 $default_color[2]
    else if string match -qrv '^\d*$' $index256
        echo "set_onedark_color: Cannot use '$index256' at index 3" > /dev/stderr
        return 3
    else if test $index256 -lt 16 -o $index256 -ge 256
        echo "set_onedark_color: Cannot use '$index256' at index 3" > /dev/stderr
        return 3
    end

    # overwrite color values
    set -g $target "$rgb" "$index256" "$default_color[3]"
end
