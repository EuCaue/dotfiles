# QT
set -x QT_QPA_PLATFORM wayland
set -x QT_QPA_PLATFORMTHEME qt5ct

# firefox
set -x MOZ_ENABLE_WAYLAND 1

# Exporting the default $EDITOR
set -x EDITOR /usr/bin/nvim
set -x VISUAL nvim
set -x FREETYPE_PROPERTIES "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0 truetype:interpreter-version=35"


set -x _ZO_MAXAGE 20000

# Add paths
fish_add_path "$HOME/.local/bin:$PATH"
fish_add_path "$HOME/dotfiles/scripts/"
fish_add_path "$HOME/.spicetify"
fish_add_path "$HOME/.cargo/bin"

set -x FZF_DEFAULT_OPTS "
    --margin=20%,10%,20%
    --layout=reverse
    --preview-window=hidden:0%
    --pointer="󰋇"
    --no-preview
    --ansi
    --color=bg:-1,bg+:236,spinner:#FFFFFF,hl:#1161cb,fg:-1,header:#FFFFFF,info:#101010,prompt:#FFFFFF,pointer:#1161cb,marker:#1161cb,fg+:250,hl+:#1161cb
"

set -x FZF_DEFAULT_OPTS_B "
    --margin=20%,10%,20%
    --layout=reverse
    --preview-window=hidden:0%
    --pointer="󰋇"
    --no-preview
    --ansi
    --color=bg:-1,bg+:236,spinner:#FFFFFF,hl:#1161cb,fg:-1,header:#FFFFFF,info:#101010,prompt:#FFFFFF,pointer:#1161cb,marker:#1161cb,fg+:250,hl+:#1161cb
"

# pnpm
set -gx PNPM_HOME "/home/caue/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
