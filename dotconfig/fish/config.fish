if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    set fish_greeting "
 I use arch BTW ඞ
  "

    if test "$TERM" = foot
        neofetch --sixel --source $WALLPAPER
        return
    end

    if test "$TERM" = xterm-kitty
        neofetch --kitty --source $WALLPAPER
        return
    end

    neofetch --ascii --source ~/dotfiles/dotconfig/neofetch/ascii.txt
end
