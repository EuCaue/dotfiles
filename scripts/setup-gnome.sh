#!/usr/bin/env bash
set -e

echo "==> Setup GNOME preferences"

### Keyboard accessibility #############################################

gsettings set org.gnome.desktop.a11y.keyboard bouncekeys-enable false
gsettings set org.gnome.desktop.a11y.keyboard bouncekeys-delay 61
gsettings set org.gnome.desktop.a11y.keyboard stickykeys-enable false
gsettings set org.gnome.desktop.a11y.keyboard mousekeys-enable false

### Repeat keys ########################################################

gsettings set org.gnome.desktop.peripherals.keyboard delay 206
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 24

### GNOME Text Editor ##################################################

gsettings set org.gnome.TextEditor keybindings 'vim'
gsettings set org.gnome.TextEditor indent-style 'space'
gsettings set org.gnome.TextEditor tab-width 2
gsettings set org.gnome.TextEditor wrap-text true
gsettings set org.gnome.TextEditor show-line-numbers true
gsettings set org.gnome.TextEditor highlight-current-line false
gsettings set org.gnome.TextEditor style-scheme 'Adwaita-dark'
gsettings set org.gnome.TextEditor restore-session false

### Nautilus ###########################################################

gsettings set org.gnome.nautilus.preferences click-policy 'single'
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'icon-view'
gsettings set org.gnome.nautilus.preferences show-delete-permanently true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.nautilus.list-view default-zoom-level 'small'
gsettings set org.gnome.nautilus.list-view use-tree-view true

### Window Manager #####################################################

gsettings set org.gnome.desktop.wm.preferences focus-mode 'sloppy'
gsettings set org.gnome.desktop.wm.preferences button-layout 'close:'
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Super>'

### Input / Interface ##################################################

gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:switch']"
gsettings set org.gnome.desktop.interface clock-format '12h'

### Quick Lofi #########################################################

QUICK_LOFI_SCHEMA="org.gnome.shell.extensions.quick-lofi"
QUICK_LOFI_SCHEMA_DIR="$HOME/.local/share/gnome-shell/extensions/quick-lofi@eucaue/schemas"

if [ -d "$QUICK_LOFI_SCHEMA_DIR" ]; then
  echo "==> Configuring Quick Lofi"

  gsettings --schemadir "$QUICK_LOFI_SCHEMA_DIR" \
    set "$QUICK_LOFI_SCHEMA" play-pause-quick-lofi "['<Control>backslash']"

  gsettings --schemadir "$QUICK_LOFI_SCHEMA_DIR" \
    set "$QUICK_LOFI_SCHEMA" increase-volume "['<Control><Alt>equal']"

  gsettings --schemadir "$QUICK_LOFI_SCHEMA_DIR" \
    set "$QUICK_LOFI_SCHEMA" decrease-volume "['<Control><Alt>minus']"

  gsettings --schemadir "$QUICK_LOFI_SCHEMA_DIR" \
    set "$QUICK_LOFI_SCHEMA" set-popup-max-height false

  gsettings --schemadir "$QUICK_LOFI_SCHEMA_DIR" \
    set "$QUICK_LOFI_SCHEMA" popup-max-height '350px'

  gsettings --schemadir "$QUICK_LOFI_SCHEMA_DIR" \
    set "$QUICK_LOFI_SCHEMA" volume 56
else
  echo "Quick Lofi not installed, skipping"
fi
