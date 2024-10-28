# qt
export QT_QPA_PLATFORM="wayland"
export QT_QPA_PLATFORMTHEME="gnome"
export QT_STYLE_OVERRIDE="Adwaita-Dark"

export XDG_CONFIG_HOME="$HOME/.config"

# firefox
export MOZ_ENABLE_WAYLAND=1

# Exporting the default $EDITOR
export EDITOR=/usr/bin/nvim
export VISUAL=nvim

# Increase zoxide limit
export _ZO_MAXAGE=200000

# mac font rendering
export FREETYPE_PROPERTIES="truetype:interpreter-version=40 cff:no-stem-darkening=0 autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,400,1250,250,1500,0 autohinter:no-stem-darkening=0"

# enable mouse
export LESS="--mouse"

# use bat as pager
export MANPAGER="bat -l man -p"

export FZF_DEFAULT_COMMAND=fd

# FZF Theme
# export FZF_DEFAULT_OPTS='
#   --color fg:bright-white,bg:black
#   --color fg+:cyan,bg+:black
#   --color hl:bright-yellow,hl+:bright-green
#   --color pointer:red,info:bright-yellow
#   --border
#   --color border:bright-blue
#   '

export FZF_DEFAULT_OPTS='
  --color fg:black,bg:white
  --color fg+:black,bg+:bright-white
  --color hl:blue,hl+:bright-blue
  --color pointer:red,info:blue
  --border
  --color border:black
  '

zstyle ':fzf-tab:*' default-color $'\033[30m'
zstyle ':fzf-tab:*' fzf-flags $(echo $FZF_DEFAULT_OPTS)
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
