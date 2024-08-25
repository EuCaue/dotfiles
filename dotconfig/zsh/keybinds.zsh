bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -s '\en' 'tmux new -s "$(basename "$PWD")"^M'
bindkey -s '\et' '~/.config/tmux/plugins/tmux-session-wizard/bin/t^M'
bindkey -s '\ea' 'tmux attach'
bindkey -s '\ez' '^uzi^M'
