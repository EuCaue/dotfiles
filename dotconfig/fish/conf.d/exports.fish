# QT
set -xg QT_QPA_PLATFORM wayland
set -xg QT_QPA_PLATFORMTHEME gnome
set -xg QT_STYLE_OVERRIDE Adwaita-Dark

# firefox
set -xg MOZ_ENABLE_WAYLAND 1

# Exporting the default $EDITOR
set -xg EDITOR /usr/bin/nvim
set -xg VISUAL nvim

# Increase zoxide limit
set -xg _ZO_MAXAGE 200000

# mac font rendering
set -xg FREETYPE_PROPERTIES "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,400,1250,250,1500,0"

# enable mouse 
set -xg LESS --mouse

set -xg FZF_DEFAULT_COMMAND fd

set -xg FZF_DEFAULT_OPTS "
    --margin=20%,10%,20%
    --layout=reverse
    --pointer="󰋇"
    --ansi
    --color=hl:#3584e4,pointer:#3584e4,marker:#3584e4,hl+:#3584e4
"

# Add paths
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/dotfiles/scripts"
fish_add_path "$HOME/.cargo/bin"
