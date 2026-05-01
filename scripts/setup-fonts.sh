#!/usr/bin/env bash
set -Eeuo pipefail

DOTFILES_DIR="${HOME}/dotfiles/dotconfig/fontconfig"
SYSTEM_CONF_D_DIR="/etc/fonts/conf.d"

FONT_FILES=(
  "99-custom-fonts.conf"
  "99-mono-override.conf"
)

echo "==> Setting up fontconfig from dotfiles"

for file in "${FONT_FILES[@]}"; do
  if [ ! -f "${DOTFILES_DIR}/${file}" ]; then
    echo "Missing file: ${DOTFILES_DIR}/${file}"
    exit 1
  fi
done

echo "==> Linking fontconfig files"
for file in "${FONT_FILES[@]}"; do
  sudo ln -sf "${DOTFILES_DIR}/${file}" "${SYSTEM_CONF_D_DIR}/${file}"
done

echo "==> Rebuilding font cache"
fc-cache -fv

echo "==> Done"
