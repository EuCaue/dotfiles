# NOTE: QT/Wayland
set QT_QPA_PLATFORM wayland
export MOZ_ENABLE_WAYLAND=1
set MOZ_ENABLE_WAYLAND 1
set QT_QPA_PLATFORMTHEME gnome
export QT_QPA_PLATFORMTHEME=gnome

# Exporting the default $EDITOR
export EDITOR=/usr/bin/nvim
export VISUAL=nvim

# Add paths
export PATH="$HOME/.local/bin:$PATH"
fish_add_path "$HOME/dotfiles/scripts/"
