function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    zle -I
    local session
    session=$(sesh list --icons | sesh-ui.sh --height 40% --reverse)
    zle reset-prompt >/dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect "$session"
  }
}

zle -N sesh-sessions

bindkey '\et' sesh-sessions
bindkey -M emacs '\et' sesh-sessions
bindkey -M vicmd '\et' sesh-sessions
bindkey -M viins '\et' sesh-sessions
