#!/usr/bin/env fish

set class_window_name gpt
set open_term hyprctl dispatch exec "[noanim;center] alacritty --class $class_window_name -e tgpt -i"
set open_gui hyprctl dispatch exec "[noanim;center] chat-gpt"
set has_term_open (echo (hyprctl clients -j) | jq -r '.[] | select(.class == "gpt") | .class')
set has_gui_open (echo (hyprctl clients -j) | jq -r '.[] | select(.class == "chat-gpt") | .class')


if test "$argv[1]" = gui

    if test -z "$has_gui_open"
        $open_gui
    else
        hyprctl dispatch togglespecialworkspace ai
    end
else

    if test -z "$has_term_open"
        $open_term
    else
        hyprctl dispatch togglespecialworkspace ai
    end

end
