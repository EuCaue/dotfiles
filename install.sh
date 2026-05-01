#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles/"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"

BOLD="\e[1m"
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

run() {
  local script="$1"

  echo
  echo -e "${BOLD}==> Running ${script}${NC}"

  if [ ! -x "$SCRIPTS_DIR/$script" ]; then
    echo -e "${RED}Script not found or not executable:${NC} $script"
    exit 1
  fi

  "$SCRIPTS_DIR/$script"
}

echo -e "${GREEN}==> Starting dotfiles setup${NC}"

run setup-packages.sh
run setup-links.sh
run setup-gnome.sh
run setup-gnome-shortcuts.sh
run setup-mono-font.sh
run setup-fonts.sh

echo
echo -e "${GREEN}==> Setup completed successfully${NC}"

echo
echo "A logout or reboot may be required for some changes to take effect"
