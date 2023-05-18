if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    set fish_greeting "
 I use arch BTW ඞ
  "
    # if test -z "$TMUX"
    #     tmux attach -d || tmux
    # end

    if test "$TERM" = foot
        neofetch --sixel --source $WALLPAPER
        echo $( hyprctl splash )
        return
    end

    if test "$TERM" = wezterm
        neofetch --sixel --source $WALLPAPER
        echo $(hyprctl splash)
        return
    end

    if test "$TERM" = xterm-kitty
        neofetch --kitty --source $WALLPAPER
        echo $( hyprctl splash )
        return
    end

    neofetch --ascii --source ~/dotfiles/dotconfig/neofetch/ascii.txt
    echo $( hyprctl splash )
end

bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste
# bind \cf ~/.cargo/bin/tms
