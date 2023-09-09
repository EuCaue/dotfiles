#!/usr/bin/env fish

set class_window_name reminder
set nvim_command hyprctl dispatch exec "[noanim;size 1550, 900;center] foot -a $class_window_name -e nvim $HOME/Documents/vault/Personal/todos.md"
set has_notes_open (echo (hyprctl clients -j) | jq -r '.[] | select(.workspace.name == "special:default") | {workspace: .workspace.name, class: .class}')

if test -z "$has_notes_open"
    $nvim_command
else
    hyprctl dispatch togglespecialworkspace default
end
