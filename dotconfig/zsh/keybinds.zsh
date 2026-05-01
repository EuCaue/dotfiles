bindkey -M viins '^[[A' history-substring-search-up
bindkey -M viins '^[[B' history-substring-search-down
bindkey -M viins -s '\en' 'tmux new -s "$(basename $(pwd))" -c "$(pwd)"^M'
bindkey -M viins -s '\ea' 'tmux attach'
bindkey -M viins -s '\ez' '^uzi^M'
bindkey -M viins -s '^f' '^uy^M'
bindkey -M viins '\er' autosuggest-accept
