#!/usr/bin/env fish

set gaps_in $(hyprctl getoption general:gaps_in -j | jq -r ".int")
set bar_css_path $HOME/dotfiles/dotconfig/ags/style.css
set bar_js_path $HOME/dotfiles/dotconfig/ags/config.js
set has_transparent $(bat $bar_css_path | grep "@define-color bar-bg-color" | awk '{print $3}')
set alt_bar_bg "@define-color bar-bg-color rgba(0, 0, 0, 0.5);"
set alt_bg_color "@define-color bg-color rgba(0, 0, 0, 0.9);"
set default_bar_bg "@define-color bar-bg-color transparent;"
set default_bg_color "@define-color bg-color rgba(0, 0, 0, 1.0);"


#  TODO: comment out the  
killall ags &
if test $gaps_in -gt 0
    hyprctl --batch "keyword master:no_gaps_when_only true" &&
        hyprctl keyword general:gaps_out 0 &&
        hyprctl keyword general:gaps_in 0 &&
        sed -i 's/margin: \[5, 15, 0, 15\],/\/\/margin: [5, 15, 0, 15],/' "$bar_js_path" &&
        sed -i 's/\/\/.*margin: \[0, 0, 0, 0\],/margin: [0, 0, 0, 0],/' "$bar_js_path" &&
        sed -i "s/$default_bar_bg/$alt_bar_bg/g; s/$default_bg_color/$alt_bg_color/g" "$bar_css_path" &&
ags & disown &
else
    hyprctl --batch "keyword master:no_gaps_when_only false"
    hyprctl keyword general:gaps_out 10 &&
        hyprctl keyword general:gaps_in 5 &&
        sed -i 's/\/\/.*margin: \[5, 15, 0, 15\],/margin: [5, 15, 0, 15],/' "$bar_js_path" &&
        sed -i 's/margin: \[0, 0, 0, 0\],/\/\/margin: [0, 0, 0, 0],/' "$bar_js_path" &&
        sed -i "s/$alt_bar_bg/$default_bar_bg/g; s/$alt_bg_color/$default_bg_color/g" "$bar_css_path" &&
ags & disown &
end
