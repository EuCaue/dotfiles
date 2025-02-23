export ZDOTDIR=$HOME/.config/zsh
export ZK_NOTEBOOK_DIR="$HOME/Documents/vault/zk"
export PATH="$HOME/.local/bin:$HOME/dotfiles/scripts:$HOME/.cargo/bin:$HOME/.bun/bin:$PATH:$HOME/.local/bin/flutter/bin:$HOME/go/bin/:$HOME/.local/share/bob/nvim-bin/"

CACHE_FILE="$HOME/.cache/zsh_cursor_settings"
if command -v gsettings >/dev/null 2>&1; then
  CURSOR_THEME=$(gsettings get org.gnome.desktop.interface cursor-theme | tr -d "'")
  CURSOR_SIZE=$(gsettings get org.gnome.desktop.interface cursor-size)

  if [ ! -f "$CACHE_FILE" ]; then
    echo "$CURSOR_THEME" >"$CACHE_FILE"
    echo "$CURSOR_SIZE" >>"$CACHE_FILE"
  fi

  read -r OLD_CURSOR_THEME <"$CACHE_FILE"
  read -r OLD_CURSOR_SIZE <"$CACHE_FILE"

  if [ "$CURSOR_THEME" != "$OLD_CURSOR_THEME" ]; then
    echo "Inherits=$CURSOR_THEME" >"$HOME/.local/share/icons/default/index.theme"
    export XCURSOR_THEME="$CURSOR_THEME"
    flatpak override --user --env=XCURSOR_THEME="$CURSOR_THEME"
    echo "$CURSOR_THEME" >"$CACHE_FILE" # Atualiza cache
  fi

  if [ "$CURSOR_SIZE" != "$OLD_CURSOR_SIZE" ]; then
    export XCURSOR_SIZE="$CURSOR_SIZE"
    flatpak override --user --env=XCURSOR_SIZE="$CURSOR_SIZE"
    echo "$CURSOR_SIZE" >>"$CACHE_FILE" # Atualiza cache
  fi
fi
