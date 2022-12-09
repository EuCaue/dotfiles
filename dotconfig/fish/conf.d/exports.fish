# NOTE: QT/Wayland
set -x QT_QPA_PLATFORM wayland
set -x MOZ_ENABLE_WAYLAND 1
set -x QT_QPA_PLATFORMTHEME gnome

# Exporting the default $EDITOR
set -x EDITOR /usr/bin/nvim
set -x VISUAL nvim

# Add paths
export PATH="$HOME/.local/bin:$HOME/dotfiles/scripts/:$PATH"
