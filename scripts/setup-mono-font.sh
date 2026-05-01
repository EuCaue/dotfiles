#!/usr/bin/env bash
set -Eeuo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
FONT_DIR="$DOTFILES/dotconfig/fontconfig"
DEFAULT_MONO_FONT="Adwaita Mono"
DEFAULT_MONO_FONT_SIZE="11"

new_mono_font="${1:-}"

if [ -z "$new_mono_font" ]; then
  echo "Usage: set-mono-font.sh 'Font Name'"
  exit 1
fi

current_gsettings_font="$(gsettings get org.gnome.desktop.interface monospace-font-name | tr -d "'")"
current_font_size="$(printf '%s\n' "$current_gsettings_font" | grep -oE '[0-9]+$' || true)"
[ -z "$current_font_size" ] && current_font_size="$DEFAULT_MONO_FONT_SIZE"

mono_font_config="$FONT_DIR/99-custom-fonts.conf"
current_mono_font="$(
  awk '
    /<match target="pattern">/ { in_match=1; wants=0; in_edit=0 }
    in_match && /<string>(mono|monospace)<\/string>/ { wants=1 }
    wants && /<edit name="family" mode="assign" binding="strong">/ { in_edit=1; next }
    in_edit && match($0, /<string>([^<]+)<\/string>/, match_data) { print match_data[1]; exit }
    /<\/match>/ { in_match=0; wants=0; in_edit=0 }
  ' "$mono_font_config"
)"

if [ -z "$current_mono_font" ]; then
  echo "Could not read current mono font from $mono_font_config" >&2
  exit 1
fi

escaped_new_mono_font="$(printf '%s\n' "$new_mono_font" | sed 's/[&|\/]/\\&/g')"
escaped_current_mono_font="$(printf '%s\n' "$current_mono_font" | sed 's/[&|\/]/\\&/g')"

cd "$FONT_DIR"

for file in 99*conf; do
  sed -i "/<edit name=\"family\" mode=\"assign\" binding=\"same\">/,/<\/edit>/ s|<string>${escaped_current_mono_font}</string>|<string>${escaped_new_mono_font}</string>|" "$file"

  sed -i "/<edit name=\"family\" mode=\"assign\" binding=\"strong\">/,/<\/edit>/ s|<string>${escaped_current_mono_font}</string>|<string>${escaped_new_mono_font}</string>|" "$file"
done

gsettings set org.gnome.desktop.interface monospace-font-name "${new_mono_font} ${current_font_size}"

"$DOTFILES/scripts/setup-fonts.sh"
