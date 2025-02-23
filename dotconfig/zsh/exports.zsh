# qt
export QT_QPA_PLATFORM="wayland"
export QT_QPA_PLATFORMTHEME="gnome"
export QT_STYLE_OVERRIDE="Adwaita-Dark"

# export DARK_MODE=$(gsettings get org.gnome.desktop.interface color-scheme)

export XDG_CONFIG_HOME="$HOME/.config"

# firefox
export MOZ_ENABLE_WAYLAND=1

# Exporting the default $EDITOR
export EDITOR=$(command -v nvim)
export VISUAL=$EDITOR

# Increase zoxide limit
export _ZO_MAXAGE=200000

# mac font rendering
export FREETYPE_PROPERTIES="truetype:interpreter-version=40 cff:no-stem-darkening=0 autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,400,1250,250,1500,0 autohinter:no-stem-darkening=0"

# enable mouse
export LESS="--mouse"
export BAT_THEME="base16"

# use bat as pager
export MANPAGER="nvim +Man!"

export FZF_DEFAULT_COMMAND=fd

# if [[ $DARK_MODE = "'prefer-dark'" ]]; then
export FZF_DEFAULT_OPTS='
  --color fg:bright-white,bg:-1
  --color fg+:cyan,bg+:-1
  --color hl:bright-yellow,hl+:bright-green
  --color pointer:red,info:bright-yellow
  --border
  --color border:bright-blue
'
# else
#   export FZF_DEFAULT_OPTS='
#   --color fg:black,bg:white
#   --color fg+:black,bg+:bright-white
#   --color hl:blue,hl+:bright-blue
#   --color pointer:red,info:blue
#   --border
#   --color border:black
#   '
#   zstyle ':fzf-tab:*' default-color $'\033[30m'
# fi
#
zstyle ':fzf-tab:*' fzf-flags $(echo $FZF_DEFAULT_OPTS)
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
