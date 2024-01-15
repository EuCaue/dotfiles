function fish_user_key_bindings
    bind --mode insert \co "$HOME/dotfiles/scripts/tmux-session.sh"
    bind --preset --mode insert --erase \ee
    bind t "tmux new -s (pwd | sed 's/.*\///g')"
end
