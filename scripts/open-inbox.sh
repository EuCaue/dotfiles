#!/usr/bin/env bash
set -euo pipefail

SESSION=zk
WINDOW=INBOX

# INBOX window lives on tmux: single instance via the zk session
if [ -n "${TMUX:-}" ]; then
  exec tmux switch-client -t "$SESSION:$WINDOW"
fi

tmux has-session -t "$SESSION" 2>/dev/null || tmuxp load -d "$HOME/.config/tmuxp/$SESSION.yaml"
exec tmux attach-session -t "$SESSION:$WINDOW"
