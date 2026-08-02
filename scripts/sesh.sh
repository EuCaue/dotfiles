#!/usr/bin/env bash

HEIGHT=80
SESH_ARGS=(--icons)

while [[ $# -gt 0 ]]; do
  case "$1" in
    --height) HEIGHT="$2"; shift 2 ;;
    -t|--tmux-only) SESH_ARGS=(-t --icons); shift ;;
    --) shift; break ;;
    *) SESH_ARGS+=("$1"); shift ;;
  esac
done

SESH_BIN="${SESH_BIN:-$HOME/go/bin/sesh}"
SESH_UI="${SESH_UI:-$HOME/dotfiles/scripts/sesh-ui.sh}"

session=$("$SESH_BIN" list "${SESH_ARGS[@]}" | "$SESH_UI" --height "$HEIGHT" --reverse)
[ -z "$session" ] && exit 0
"$SESH_BIN" connect "$session"
