bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey -s '\en' 'tmux new -s "$(basename "$PWD")"^M'
bindkey -s '\et' '~/.config/tmux/plugins/tmux-session-wizard/bin/t^M'
bindkey -s '\ea' 'tmux attach'
bindkey -s '\ez' '^uzi^M'
