#!/usr/bin/env fish
set -e -U FONT_NAME

if test $TERM = linux
    set -Ux FONT_NAME $(fc-list --format="%{family}\n" | cut -d , -f 1 | sort | uniq | rofi -dmenu)
else
    if test -z $argv[1]
        set -Ux FONT_NAME "MesloLGL Nerd Font"
    else
        set -Ux FONT_NAME $argv[1]
    end
end

function change_font
    sed -i "s#\(--font-primary: \).*#\1\"$FONT_NAME\";#" $HOME/.config/WebCord/Themes/black
    sed -i "s#\(gtk-font-name=\).*#\1$FONT_NAME 12#" $HOME/.config/gtk-3.0/settings.ini
    sed -i "s#\(font \).*#\1\"$FONT_NAME 12\"#" $HOME/dotfiles/dotconfig/zathura/zathurarc
    sed -i "s#\(FONT \).*#\1\"$FONT_NAME 12\"#" $HOME/dotfiles/scripts/gsettings.fish
    sed -i "s#\(text_font=\).*#\1$FONT_NAME#" $HOME/.config/swappy/config
    sed -i "s#\(font-family: \).*#\1\"$FONT_NAME\";#" $HOME/.config/waybar/style.css
    sed -i 's#\(^font_family \).*#\1'"$FONT_NAME"'#' $HOME/dotfiles/dotconfig/kitty/kitty.conf
    sed -i 's#^ *family: .*#family: '$FONT_NAME'#' ~/.config/alacritty/alacritty.yml
    sed -i "s#^\(font=\)[^:]*#\1$FONT_NAME#" $HOME/dotfiles/dotconfig/foot/foot.ini
    sed -i "s#\(font-family: \).*#\1\"$FONT_NAME\";#" $HOME/.config/waybar/style.css
    killall waybar && waybar & disown &
    sed -i "s#\(font: \).*#\1\"$FONT_NAME 13\";#" $HOME/dotfiles/dotconfig/rofi/config.rasi
    sed -i 's@user_pref("font.name.monospace.x-western",[^)]*)@user_pref("font.name.monospace.x-western", "'$FONT_NAME'")@g' /home/caue/.mozilla/firefox/9tzkj9s8.default-release/user.js
    sed -i 's@user_pref("font.name.sans-serif.x-western",[^)]*)@user_pref("font.name.sans-serif.x-western", "'$FONT_NAME'")@g' /home/caue/.mozilla/firefox/9tzkj9s8.default-release/user.js
    sed -i 's@user_pref("font.name.serif.x-western",[^)]*)@user_pref("font.name.serif.x-western", "'$FONT_NAME'")@g' /home/caue/.mozilla/firefox/9tzkj9s8.default-release/user.js
    gsettings set org.gnome.desktop.interface font-name $FONT_NAME
    gsettings set org.gnome.desktop.interface document-font-name $FONT_NAME
    gsettings set org.gnome.desktop.interface monospace-font-name $FONT_NAME
end

change_font
