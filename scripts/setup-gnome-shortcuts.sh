#!/usr/bin/env bash
set -e

echo "==> Setup GNOME shortcuts"

### Easy to change variables ##########################################

for bin in zen zen-bin zen-browser; do
  if command -v "$bin" >/dev/null 2>&1; then
    BROWSER="$bin"
    break
  fi
done

TERMINAL="ghostty"
FILE_MANAGER="nautilus -w"
EDITOR_CMD="$TERMINAL -e nvim"
TMUX_SESSION="caue"
HOME_DIR="$HOME"

### WM keybindings #####################################################

gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>f']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Shift><Super>f']"
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>w']"
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>Up']"
gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Super>Down','<Alt>F5']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings cycle-group "['<Super>Tab']"

gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Super><Shift>s']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>h']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>l']"

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Super>h']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Super>l']"

for i in {1..9}; do
  gsettings set org.gnome.desktop.wm.keybindings "switch-to-workspace-$i" "['<Super>$i']"
done
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>0']"

for i in {1..9}; do
  gsettings set org.gnome.desktop.wm.keybindings "move-to-workspace-$i" "['<Super><Shift>$i']"
done
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Shift>0']"

for i in {1..9}; do
  gsettings set org.gnome.shell.keybindings "switch-to-application-$i" "['<Super><Alt>$i']"
done

### Mutter tiling ######################################################

gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Shift><Super>a']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Shift><Super>d']"

### Media keys #########################################################

gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['<Super>equal']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['<Super>minus']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "['<Super>backslash']"
gsettings set org.gnome.settings-daemon.plugins.media-keys mic-mute "['<Shift><Super>backslash']"
gsettings set org.gnome.settings-daemon.plugins.media-keys play "['<Super>BackSpace']"
gsettings set org.gnome.settings-daemon.plugins.media-keys next "['<Super>bracketright']"
gsettings set org.gnome.settings-daemon.plugins.media-keys previous "['<Super>bracketleft']"
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Super>comma']"
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Shift><Super>z']"

### Custom shortcuts ###################################################

BASE_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
SCHEMA="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"

CUSTOM_KEYS=(
  "gradia-screenshot:flatpak run be.alexandervanhee.gradia --screenshot=INTERACTIVE:<Shift><Alt>s"
  "open-browser:$BROWSER:<Super>b"
  "open-daily-note:$TERMINAL -e zsh -c \"zk d\":<Super>t"
  "open-iotas:flatpak run org.gnome.World.Iotas:<Super>i"
  "open-nautilus:$FILE_MANAGER:<Super>e"
  "open-neovim:$EDITOR_CMD:<Super>n"
  "open-terminal:$TERMINAL:<Control><Super>Return"
  "open-zk:$TERMINAL -e tmux new-session -A -s zk:<Super>z"
  "play-pause:playerctl play-pause:<Super>d"
  "tmux-home:$TERMINAL -e tmux new-session -A -s $TMUX_SESSION:<Shift><Super>Return"
  "tmux-sessions:$TERMINAL -e \"$HOME_DIR/dotfiles/scripts/sesh.sh\":<Super>Return"
)

paths=()
for i in "${!CUSTOM_KEYS[@]}"; do
  paths+=("'$BASE_PATH/custom$i/'")
done

paths_str=$(
  IFS=,
  echo "${paths[*]}"
)

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[$paths_str]"

for i in "${!CUSTOM_KEYS[@]}"; do
  entry="${CUSTOM_KEYS[$i]}"

  name="${entry%%:*}"
  rest="${entry#*:}"
  cmd="${rest%%:*}"
  key="${rest##*:}"

  path="$BASE_PATH/custom$i/"

  gsettings set "$SCHEMA:$path" name "$name"
  gsettings set "$SCHEMA:$path" command "$cmd"
  gsettings set "$SCHEMA:$path" binding "$key"
done
