bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -s '\en' 'tmux new -s "$(basename $(pwd))" -c "$(pwd)"^M'
bindkey -s '\et' '~/.config/tmux/plugins/tmux-session-wizard/bin/t^M'
bindkey -s '\ea' 'tmux attach'
bindkey -s '\ez' '^uzi^M'
bindkey -s '^f' '^uy^M'
bindkey '\er' autosuggest-accept
