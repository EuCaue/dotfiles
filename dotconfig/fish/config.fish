if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    set fish_greeting "
 I use arch BTW ඞ
  "
    neofetch --sixel --source $WALLPAPER
end

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
fish_add_path /home/caue/.spicetify
fish_add_path /home/caue/.local/bin/
fish_add_path /home/caue/.local/share/Steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg
