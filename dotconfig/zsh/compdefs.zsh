# completion for custom aliases
compdef _files mx
compdef _files extract
compdef _files nm
compdef _pgrep killall

_git-bc() {
  _git-branch
}

_git-bs() {
  _git-branch
}
_set-cursor-theme() {
  if (( CURRENT == 3 )); then
    compadd dark light
    return
  fi
  # :h:t -> theme dir name, no subshell per entry; only dirs with cursors/
  local -a themes
  themes=(/usr/share/icons/*/cursors(N:h:t))
  compadd -a themes
}

_set-cursor-size() {
  local -a sizes
  sizes=({16..99})
  compadd "$sizes[@]"
}

compdef _git-bc git-bc
compdef _git-bs git-bs
compdef _set-cursor-theme set-cursor-theme
compdef _set-cursor-size set-cursor-size

_tmux-workspace() {
  local -a sessions opts
  sessions=($HOME/.config/tmuxp/*.yaml(N:t:r))
  opts=('--spawn:load missing sessions without attaching')
  _describe -t sessions 'tmuxp session' sessions
  _describe -t opts 'option' opts
}
compdef _tmux-workspace tmux-workspace

zstyle ':completion:*:*:kill:*:processes' command 'ps xo pid,user:10,cmd'
zstyle ':completion:*:*:git:*' user-commands bc:'Checkout or switch to a branch'
zstyle ':completion:*:*:git-diff:*' tag-order 'files' 'revisions'
