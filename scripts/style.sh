#!/usr/bin/env zsh

# === Defaults ===

# light
DEFAULT_CURSOR_LIGHT="Adwhite"
DEFAULT_CURSOR_SIZE_LIGHT=24
DEFAULT_BACKGROUND_LIGHT="$HOME/Pictures/wallpapers/wallhaven-6k6g9q.png"
DEFAULT_BRIGHTNESS_LIGHT=75

# dark
DEFAULT_CURSOR_DARK="Adwaita"
DEFAULT_CURSOR_SIZE_DARK=24
DEFAULT_BACKGROUND_DARK="$HOME/Pictures/wallpapers/wallhaven-9o8k9w.jpg"

DEFAULT_BRIGHTNESS_DARK=100

# files
LOG_FILE="$HOME/.local/share/style-switch.log"
THEME_FILE="/tmp/theme"
FLAG_FILE="/tmp/style_has_runned"
STATE_DIR="$HOME/.local/state/style-switch"

MODE="$1"

source "$HOME/dotfiles/dotconfig/zsh/exports.zsh"

get_cursor_state_file() {
  local mode="$1"
  echo "$STATE_DIR/cursor-${mode}.env"
}

save_cursor_override_for_mode() {
  local mode="$1"
  local cursor="$2"
  local size="$3"
  local state_file

  state_file=$(get_cursor_state_file "$mode")
  mkdir -p "$STATE_DIR"
  printf 'STYLE_CURSOR_OVERRIDE=%q\nSTYLE_SIZE_OVERRIDE=%q\n' "$cursor" "$size" >"$state_file"
}

save_current_cursor_override() {
  local current_mode current_cursor current_size state_file

  current_mode=$(gsettings get org.gnome.desktop.interface color-scheme | grep -q "dark" && echo "dark" || echo "light")
  current_cursor=$(gsettings get org.gnome.desktop.interface cursor-theme | tr -d "'")
  current_size=$(gsettings get org.gnome.desktop.interface cursor-size)
  state_file=$(get_cursor_state_file "$current_mode")

  mkdir -p "$STATE_DIR"
  printf 'STYLE_CURSOR_OVERRIDE=%q\nSTYLE_SIZE_OVERRIDE=%q\n' "$current_cursor" "$current_size" >"$state_file"
}

if [[ "$MODE" == "--save-current-cursor" ]]; then
  save_current_cursor_override
  exit 0
fi

echo "$MODE" >$THEME_FILE #

if [ ! -f "$FLAG_FILE" ]; then
  touch "$FLAG_FILE"
  exit 0
fi

shift

while [[ $# -gt 0 ]]; do
  case "$1" in
  --cursor)
    CUSTOM_CURSOR="$2"
    shift 2
    ;;
  --size)
    CUSTOM_SIZE="$2"
    shift 2
    ;;
  --brightness)
    CUSTOM_BRIGHTNESS="$2"
    shift 2
    ;;
  --background)
    CUSTOM_BACKGROUND="$2"
    shift 2
    ;;
  *)
    echo "⚠️  Unknown option: $1" >&2
    shift
    ;;
  esac
done

# === detect current gnome settings ===
CURRENT_MODE=$(gsettings get org.gnome.desktop.interface color-scheme | grep -q "dark" && echo "dark" || echo "light")
CURRENT_CURSOR=$(gsettings get org.gnome.desktop.interface cursor-theme | tr -d "'")
CURRENT_SIZE=$(gsettings get org.gnome.desktop.interface cursor-size)
CURRENT_BACKGROUND=$(gsettings get org.gnome.desktop.background picture-uri | sed "s/'//g" | sed "s/file:\/\///")
CURRENT_BRIGHTNESS=$(brightnessctl g >/dev/null 2>&1 && brightnessctl g || echo "unknown")
STATE_FILE=$(get_cursor_state_file "$MODE")

if [[ -f "$STATE_FILE" ]]; then
  source "$STATE_FILE"
fi

# apply defaults based on mode
if [[ "$MODE" == "dark" ]]; then
  CURSOR="${CUSTOM_CURSOR:-${STYLE_CURSOR_OVERRIDE:-$DEFAULT_CURSOR_DARK}}"
  SIZE="${CUSTOM_SIZE:-${STYLE_SIZE_OVERRIDE:-$DEFAULT_CURSOR_SIZE_DARK}}"
  BACKGROUND="${CUSTOM_BACKGROUND:-$DEFAULT_BACKGROUND_DARK}"
  BRIGHTNESS="${CUSTOM_BRIGHTNESS:-$DEFAULT_BRIGHTNESS_DARK}"
elif [[ "$MODE" == "light" ]]; then
  CURSOR="${CUSTOM_CURSOR:-${STYLE_CURSOR_OVERRIDE:-$DEFAULT_CURSOR_LIGHT}}"
  SIZE="${CUSTOM_SIZE:-${STYLE_SIZE_OVERRIDE:-$DEFAULT_CURSOR_SIZE_LIGHT}}"
  BACKGROUND="${CUSTOM_BACKGROUND:-$DEFAULT_BACKGROUND_LIGHT}"
  BRIGHTNESS="${CUSTOM_BRIGHTNESS:-$DEFAULT_BRIGHTNESS_LIGHT}"
else
  echo "Usage: style <light|dark> [--cursor THEME] [--size NUM] [--brightness NUM] [--background PATH]"
  exit 1
fi

if [[ -n "$CUSTOM_CURSOR" || -n "$CUSTOM_SIZE" ]]; then
  save_cursor_override_for_mode "$MODE" "$CURSOR" "$SIZE"
fi

log() {
  local timestamp="$(date '+%Y-%m-%d %H:%M:%S')"
  echo "[$timestamp] $@" >>"$LOG_FILE"
}

# write log comparing old/new
log "Mode: $CURRENT_MODE → $MODE"
log "Cursor: $CURRENT_CURSOR → $CURSOR"
log "Cursor Size: $CURRENT_SIZE → $SIZE"
log "Background: $CURRENT_BACKGROUND → $BACKGROUND"
log "Brightness: ${CURRENT_BRIGHTNESS}% → ${BRIGHTNESS}%"
log "-----------------------------------------------------------"

source "$HOME/dotfiles/dotconfig/zsh/alias.zsh"
if [[ "$MODE" == "dark" ]]; then
  echo "🌙 Switching to dark mode..."
  gsettings set org.gnome.desktop.interface color-scheme "'prefer-dark'"
  set-cursor-theme "$CURSOR"
  set-cursor-size "$SIZE"
  gsettings set org.gnome.desktop.background picture-uri-dark "file://$BACKGROUND"
  sed -i "s/light/dark/" "$HOME/.config/nvim/lua/user/core/options.lua"
  # brightnessctl s "${BRIGHTNESS}%"
  notify-send "Dark mode activated"
else
  echo "☀️  Switching to light mode..."
  gsettings set org.gnome.desktop.interface color-scheme "'prefer-light'"
  set-cursor-theme "$CURSOR"
  set-cursor-size "$SIZE"
  gsettings set org.gnome.desktop.background picture-uri "file://$BACKGROUND"
  sed -i "s/dark/light/" "$HOME/.config/nvim/lua/user/core/options.lua"
  # brightnessctl s "${BRIGHTNESS}%"
  notify-send "Light mode activated"
fi

if command -v tmux >/dev/null; then
  tmux set-environment -g FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS"
  tmux set-environment -g BAT_THEME "$BAT_THEME"

  tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}' |
    while read -r entry; do
      pane="${entry%% *}"
      cmd="${entry##* }"

      # only target zsh or bash panes that are idle shells
      if [[ "$cmd" =~ ^(zsh|bash|sh|fish)$ ]]; then
        tmux send-keys -t "$pane" C-x
        sleep 0.5
      fi
    done
fi

log "✅ Mode set successfully!"
