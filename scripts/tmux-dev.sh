#!/usr/bin/env bash

CODE_WINDOW="editor"
DEV_WINDOW="dev"
GIT="git"
OPENCODE="opencode"

tmux rename-window -t 1 "$CODE_WINDOW"

tmux new-window -n "$DEV_WINDOW"
tmux select-window -t "$DEV_WINDOW"
tmux split-window -v -p 20
tmux select-pane -U

tmux new-window -n "$GIT"
tmux new-window -n "$OPENCODE"

tmux select-window -t "$CODE_WINDOW"
