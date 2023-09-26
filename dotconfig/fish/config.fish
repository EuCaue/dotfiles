if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source
    set fish_greeting "
 I use arch BTW ඞ
  "
    # BEST THING 
    echo -en '\e]22;ibeam\e\\'
    if test -z "$TMUX"
        tmux attach -t home || tmux new -s home
    end

    # if test "$TERM" = foot
    #     sleep 0.1
    #     # neofetch --sixel --source $WALLPAPER
    #     hyprctl splash
    #     return 0
    # end
    #
    # if test "$TERM" = wezterm
    #     # neofetch --sixel --source $WALLPAPER
    #     echo $(hyprctl splash)
    #     return 0
    # end
    #
    # if test "$TERM" = xterm-kitty
    #     # neofetch --kitty --source $WALLPAPER
    #     echo $( hyprctl splash )
    #     return 0
    # end

    # neofetch --ascii --source ~/dotfiles/dotconfig/neofetch/ascii.txt
    echo $(hyprctl splash)
end
set --global fish_color_error brred --bold
bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste
