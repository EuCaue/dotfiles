if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    set fish_greeting "
 I use arch BTW ඞ
  "
    neofetch --sixel --source $WALLPAPER
end
