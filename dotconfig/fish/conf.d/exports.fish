# NOTE: QT/Wayland
set -x QT_QPA_PLATFORM wayland
set -x MOZ_ENABLE_WAYLAND 1
set -x QT_QPA_PLATFORMTHEME gnome

# Exporting the default $EDITOR
set -x EDITOR /usr/bin/nvim
set -x VISUAL nvim
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Add paths
fish_add_path "$HOME/.local/bin:$PATH"
fish_add_path "$HOME/dotfiles/scripts/"
fish_add_path "/home/caue/.spicetify"
fish_add_path "/home/caue/.local/bin/"
fish_add_path "/home/caue/.local/share/Steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg"
