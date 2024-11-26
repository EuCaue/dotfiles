export ZDOTDIR=$HOME/.config/zsh
export ZK_NOTEBOOK_DIR="$HOME/Documents/vault/zk"
export PATH="$HOME/.local/bin:$HOME/dotfiles/scripts:$HOME/.cargo/bin:$HOME/.bun/bin:$PATH:$HOME/.local/bin/flutter/bin:$HOME/go/bin/"
CURSOR_THEME=$(gsettings get org.gnome.desktop.interface cursor-theme | tr -d "'")
CURSOR_SIZE=$(gsettings get org.gnome.desktop.interface cursor-size)

if [ -z "$XCURSOR_THEME" ] || [ "$XCURSOR_THEME" != "$CURSOR_THEME" ]; then
	sed -i "s/^\(Inherits=\).*$/\1$CURSOR_THEME/" "$HOME/.local/share/icons/default/index.theme"
	export XCURSOR_THEME="$CURSOR_THEME" &&
  flatpak override --user --env=XCURSOR_THEME="$CURSOR_THEME" 
fi

if [ -z "$XCURSOR_SIZE" ] || [ "$XCURSOR_SIZE" != "$CURSOR_SIZE" ]; then
	export XCURSOR_SIZE="$CURSOR_SIZE" &&
  flatpak override --user --env=XCURSOR_SIZE="$CURSOR_SIZE" 
fi
