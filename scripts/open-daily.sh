#!/usr/bin/env bash
set -euo pipefail

session=${ZK_SESSION:-zk}
window=${ZK_WINDOW:-daily}
target="$session:$window"
file=$("$HOME/Documents/zk/scripts/zk-todo" open)

if ! tmux has-session -t "$session" 2>/dev/null; then
  tmuxp load -d "$HOME/.config/tmuxp/$session.yaml"
fi

created=false
if ! tmux list-windows -t "$session" -F '#{window_name}' | grep -qx "$window"; then
  tmux new-window -t "$session" -n "$window"
  created=true
fi

if [ "$created" = true ]; then
  tmux send-keys -t "$target" "nvim +'/##.*Today' +'nohlsearch' \"$file\"" Enter
else
  current=$(tmux display-message -p -t "$target" '#{pane_current_command}')
  if [ "$current" = "nvim" ]; then
    tmux send-keys -t "$target" Escape
    tmux send-keys -t "$target" ":edit $file" Enter
    tmux send-keys -t "$target" ":nohlsearch" Enter
  else
    tmux send-keys -t "$target" "nvim +'/##.*Today' +'nohlsearch' \"$file\"" Enter
  fi
fi

if [ -n "${TMUX:-}" ]; then
  exec tmux switch-client -t "$target"
fi

exec tmux attach-session -t "$target"
