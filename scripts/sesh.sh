#!/usr/bin/env bash

session=$($HOME/go/bin/sesh list --icons | "$HOME"/dotfiles/scripts/sesh-ui.sh --height 80% --reverse)
[ -z "$session" ] && exit 0
exec $HOME/go/bin/sesh connect "$session"
