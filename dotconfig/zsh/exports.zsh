# qt
export QT_QPA_PLATFORM="wayland"
export QT_QPA_PLATFORMTHEME="gnome"
export QT_STYLE_OVERRIDE="Adwaita-Dark"

# firefox
export MOZ_ENABLE_WAYLAND=1

# Exporting the default $EDITOR
export EDITOR=/usr/bin/nvim
export VISUAL=nvim

# Increase zoxide limit
export _ZO_MAXAGE=200000

# mac font rendering
export FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,400,1250,250,1500,0 autohinter:no-stem-darkening=0"

# enable mouse
export LESS="--mouse"

# use bat as pager
export MANPAGER="bat -l man -p"

export FZF_DEFAULT_COMMAND=fd

# FZF Theme
export FZF_DEFAULT_OPTS='
  --color fg:#5d6466,bg:#1e2527
  --color bg+:#ef7d7d,fg+:#2c2f30
  --color hl:#dadada,hl+:#26292a,gutter:#1e2527
  --color pointer:#373d49,info:#606672
  --border
  --color border:#1e2527
  --height 13'

# Add paths
export PATH="$HOME/.local/bin:$HOME/dotfiles/scripts:$HOME/.cargo/bin:$HOME/.bun/bin:$PATH"
