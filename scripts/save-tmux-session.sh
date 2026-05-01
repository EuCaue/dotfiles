#!/usr/bin/env bash

ln -sf "$(readlink -f ~/.local/share/tmux/resurrect/last)" \
~/dotfiles/dotconfig/last
