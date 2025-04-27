#!/usr/bin/env bash

for i in {1..9}; do gsettings set "org.gnome.desktop.wm.keybindings" "switch-to-workspace-$i" "['<Super>$i']"; done

gsettings set "org.gnome.desktop.wm.keybindings" "switch-to-workspace-10" "['<Super>0']"

for i in {1..9}; do gsettings set "org.gnome.desktop.wm.keybindings" "move-to-workspace-$i" "['<Super><Shift>$i']"; done

gsettings set "org.gnome.desktop.wm.keybindings" "move-to-workspace-10" "['<Super><Shift>0']"

for i in {1..9}; do gsettings set "org.gnome.shell.keybindings" "switch-to-application-$i" "['<Super><Alt>$i']"; done
