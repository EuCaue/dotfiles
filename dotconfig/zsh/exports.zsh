# qt
#  TODO: add support for dark light mode
THEME_FILE="/tmp/theme"
if [[ -f "$THEME_FILE" ]]; then
  export THEME=$(<"$THEME_FILE")
else
  export THEME=light # fallback
fi
export QT_QPA_PLATFORM="wayland"
export QT_QPA_PLATFORMTHEME="gnome"
export QT_STYLE_OVERRIDE=$([ "$THEME" = "light" ] && echo "Adwaita" || echo "Adwaita-Dark")
# export QT_STYLE_OVERRIDE="Adwaita-Dark"
export XDG_CONFIG_HOME="$HOME/.config"
export DOTFILES="$HOME/dotfiles"

# firefox
export MOZ_ENABLE_WAYLAND=1

# Exporting the default $EDITOR
export EDITOR=$(command -v nvim)
export VISUAL=$EDITOR

# Increase zoxide limit
export _ZO_MAXAGE=200000

# export PATH="$HOME/.local/bin:$HOME/dotfiles/scripts:$HOME/.cargo/bin:$HOME/.bun/bin:$PATH:$HOME/.local/bin/flutter/bin:$HOME/go/bin/:$HOME/.local/share/bob/nvim-bin/"
export PATH="$HOME/.local/bin:$HOME/dotfiles/scripts:$HOME/.cargo/bin:$HOME/.bun/bin:$HOME/.local/bin/flutter/bin:$HOME/go/bin:$PATH"

# mac font rendering
# export FREETYPE_PROPERTIES="truetype:interpreter-version=40 cff:no-stem-darkening=0 autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,400,1250,250,1500,0 autohinter:no-stem-darkening=0"
# export FREETYPE_PROPERTIES="truetype:interpreter-version=40 cff:no-stem-darkening=0 autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,400,1250,250,1500,0 autohinter:no-stem-darkening=0 lcd_filter=default rgba=rgb"
# export FREETYPE_PROPERTIES="truetype:interpreter-version=40\
#  autofitter:no-stem-darkening=0\
#  autofitter:darkening-parameters=500,0,1000,500,2500,500,4000,0\
#  cff:no-stem-darkening=0\
#  cff:darkening-parameters=500,475,1000,475,2500,475,4000,0\
#  type1:no-stem-darkening=0\
#  type1:darkening-parameters=500,475,1000,475,2500,475,4000,0\
#  t1cid:no-stem-darkening=0\
#  t1cid:darkening-parameters=500,475,1000,475,2500,475,4000,0"

export FREETYPE_PROPERTIES="truetype:interpreter-version=40 \
autofitter:no-stem-darkening=1 \
autofitter:darkening-parameters=0,0,0,0,0,0,0,0 \
cff:no-stem-darkening=1 \
cff:darkening-parameters=0,0,0,0,0,0,0,0 \
type1:no-stem-darkening=1 \
type1:darkening-parameters=0,0,0,0,0,0,0,0 \
t1cid:no-stem-darkening=1 \
t1cid:darkening-parameters=0,0,0,0,0,0,0,0"
# enable mouse
export LESS="--mouse"
export BAT_THEME="ansi"

# use bat as pager
export MANPAGER="nvim +Man!"

export FZF_DEFAULT_COMMAND=fd

if [[ $THEME = "dark" ]]; then
  export FZF_DEFAULT_OPTS='
  --color fg:bright-white,bg:-1
  --color fg+:cyan,bg+:-1
  --color hl:bright-yellow,hl+:bright-green
  --color pointer:red,info:bright-yellow
  --border
  --color border:bright-blue
'
  zstyle ':fzf-tab:*' default-color $'\033[37m' # white fg
else
  export FZF_DEFAULT_OPTS='
  --color fg:black,bg:white
  --color fg+:black,bg+:bright-white
  --color hl:blue,hl+:bright-blue
  --color pointer:red,info:blue
  --border
  --color border:black
  '
  zstyle ':fzf-tab:*' default-color $'\033[30m' # black fg
fi

zstyle ':fzf-tab:*' fzf-flags $(echo $FZF_DEFAULT_OPTS)
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
