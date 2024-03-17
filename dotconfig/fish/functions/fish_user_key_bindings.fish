function fish_user_key_bindings
    bind --mode insert \co "$HOME/.config/tmux/plugins/tmux-session-wizard/session-wizard.sh"
    bind --preset --mode insert --erase \ee
    bind t "tmux new -s (pwd | sed 's/.*\///g')"
    bind a "tmux attach"
    bind z zi
end
