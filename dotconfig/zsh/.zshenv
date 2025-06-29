export ZDOTDIR=$HOME/.config/zsh
export ZK_NOTEBOOK_DIR="$HOME/Documents/vault/zk"
export PATH="$HOME/.local/bin:$HOME/dotfiles/scripts:$HOME/.cargo/bin:$HOME/.bun/bin:$PATH:$HOME/.local/bin/flutter/bin:$HOME/go/bin/:$HOME/.local/share/bob/nvim-bin/"

if command -v gsettings >/dev/null 2>&1; then
  CURSOR_THEME=$(gsettings get org.gnome.desktop.interface cursor-theme | tr -d "'")
  CURSOR_SIZE=$(gsettings get org.gnome.desktop.interface cursor-size)
  DARK_MODE=$(gsettings get org.gnome.desktop.interface color-scheme)
  if [[ $DARK_MODE = "'prefer-dark'" ]]; then
    export IS_DARKMODE=true
  else
    export IS_DARKMODE=false
  fi

  if command -v flatpak >/dev/null 2>&1; then
    FLATPAK_INSTALLED=1
  else
    FLATPAK_INSTALLED=0
  fi

  if [ -z "$XCURSOR_THEME" ] || [ "$XCURSOR_THEME" != "$CURSOR_THEME" ]; then
    sed -i "s/^\(Inherits=\).*$/\1$CURSOR_THEME/" "$HOME/.local/share/icons/default/index.theme"
    export XCURSOR_THEME="$CURSOR_THEME"
    if [ "$FLATPAK_INSTALLED" -eq 1 ]; then
      flatpak override --user --env=XCURSOR_THEME="$CURSOR_THEME"
    fi
  fi

  if [ -z "$XCURSOR_SIZE" ] || [ "$XCURSOR_SIZE" != "$CURSOR_SIZE" ]; then
    export XCURSOR_SIZE="$CURSOR_SIZE"
    if [ "$FLATPAK_INSTALLED" -eq 1 ]; then
      flatpak override --user --env=XCURSOR_SIZE="$CURSOR_SIZE"
    fi
  fi
fi

[ -z "$IS_DARKMODE" ] && export IS_DARKMODE=true
