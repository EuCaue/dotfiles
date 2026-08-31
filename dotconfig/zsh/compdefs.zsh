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
  local -a themes
  for theme in /usr/share/icons/*(N); do
    theme=$(basename $theme)
    themes+=("$theme")
  done
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
zstyle ':completion:*:*:kill:*:processes' command 'ps xo pid,user:10,cmd'
zstyle ':completion:*:*:git:*' user-commands bc:'Checkout or switch to a branch'
zstyle ':completion:*:*:git-diff:*' tag-order 'files' 'revisions'
