function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    zle -I
    sesh.sh --height 40%
    zle reset-prompt >/dev/null 2>&1 || true
  }
}

zle -N sesh-sessions

bindkey '\et' sesh-sessions
bindkey -M emacs '\et' sesh-sessions
bindkey -M vicmd '\et' sesh-sessions
bindkey -M viins '\et' sesh-sessions
