#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles/dotconfig"
CONFIG_DIR="$HOME/.config"

echo
echo "==> Systemd user units"

SYSTEMD_SRC="$DOTFILES_DIR/systemd/user"
SYSTEMD_DEST="$HOME/.config/systemd/user"

mkdir -p "$SYSTEMD_DEST"

for unit in "$SYSTEMD_SRC"/*; do
  name="$(basename "$unit")"
  dest="$SYSTEMD_DEST/$name"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Already exists, skipping: $name"
    continue
  fi

  echo "Linking: $name"
  ln -s "$unit" "$dest"
done

systemctl --user daemon-reload || true

link_dir() {
  local src="$DOTFILES_DIR/$1"
  local dest="$CONFIG_DIR/$1"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Already exists, skipping: $dest"
    return
  fi

  echo "Linking $1"
  ln -s "$src" "$dest"
}

link_file() {
  local src="$DOTFILES_DIR/$1"
  local dest="$2"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Already exists, skipping: $dest"
    return
  fi

  echo "Linking $(basename "$dest")"
  ln -s "$src" "$dest"
}

echo
echo "==> Apps in .config"

link_dir ghostty
link_dir nvim
link_dir tmux
link_dir yazi
link_dir zsh
link_dir tmuxp

echo
echo "==> Starship"
link_file starship.toml "$CONFIG_DIR/starship.toml"

echo
echo "==> Git"
link_file gitconfig "$HOME/.gitconfig"

echo
echo "==> Linking completed"
