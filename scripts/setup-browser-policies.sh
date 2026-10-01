#!/bin/bash

# Setup DNF hooks to auto-apply browser policies after updates.
# Policies files live in dotconfig/policies/.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
POLICIES_DIR="$DOTFILES_DIR/dotconfig/policies"

FF_POLICIES="$POLICIES_DIR/firefox-policies.json"
CHROME_POLICIES="$POLICIES_DIR/chrome-policies.json"
HOOK_SCRIPT="/usr/local/bin/apply-browser-policies"

for f in "$FF_POLICIES" "$CHROME_POLICIES"; do
    if [ ! -f "$f" ]; then
        echo "Error: policies file not found at $f"
        exit 1
    fi
done

# Firefox-based: package -> install dir
declare -A FIREFOX_BROWSERS=(
    [firefox]="/usr/lib64/firefox"
    [firefox-esr]="/usr/lib64/firefox"
    [icecat]="/usr/lib64/icecat"
    [seamonkey]="/usr/lib64/seamonkey"
    [waterfox]="/usr/lib64/waterfox"
    [librewolf]="/usr/lib64/librewolf"
    [floorp]="/opt/floorp"
    [zen-browser]="/opt/zen"
    [palemoon]="/usr/lib64/palemoon"
)

# Chromium-based: package -> policies dir (platform-specific paths)
declare -A CHROME_BROWSERS=(
    [chromium]="/usr/lib64/chromium"
    [chromium-freeworld]="/usr/lib64/chromium"
    [google-chrome-stable]="/opt/google/chrome"
    [google-chrome-beta]="/opt/google/chrome-beta"
    [google-chrome-unstable]="/opt/google/chrome-unstable"
    [brave-browser]="/opt/brave.com/brave"
    [vivaldi-stable]="/opt/vivaldi"
    [microsoft-edge-stable]="/opt/microsoft/msedge"
    [opera-stable]="/usr/lib64/opera"
    [falkon]="/usr/lib64/falkon"
    [qutebrowser]="/usr/lib64/qutebrowser"
    [konqueror]="/usr/lib64/konqueror"
)

# --- Write hook script ---
sudo tee "$HOOK_SCRIPT" > /dev/null << 'HOOK'
#!/bin/bash
# Auto-applies browser policies after DNF transactions.

FF="/home/caue/dotfiles/dotconfig/policies/firefox-policies.json"
CHROME="/home/caue/dotfiles/dotconfig/policies/chrome-policies.json"

# Firefox-based: copy policies.json into distribution/
for dir in \
    /usr/lib64/firefox \
    /usr/lib64/firefox-esr \
    /usr/lib64/icecat \
    /usr/lib64/seamonkey \
    /usr/lib64/waterfox \
    /usr/lib64/librewolf \
    /opt/floorp \
    /opt/zen \
    /usr/lib64/palemoon
do
    if [ -d "$dir" ] && [ -f "$FF" ]; then
        mkdir -p "$dir/distribution"
        cp -f "$FF" "$dir/distribution/policies.json"
        echo "Applied Firefox policies to $dir"
    fi
done

# Chromium-based: each browser reads from its own policy path
CHROMIUM_DIRS=(
    "/usr/lib64/chromium/policies/managed"
    "/etc/opt/chrome/policies/managed"
    "/etc/opt/chrome-beta/policies/managed"
    "/etc/opt/chrome-unstable/policies/managed"
    "/etc/brave/policies/managed"
    "/etc/vivaldi/policies/managed"
    "/etc/opt/edge/policies/managed"
    "/etc/opt/opera/policies/managed"
    "/usr/lib64/falkon/policies/managed"
    "/usr/lib64/qutebrowser/policies/managed"
    "/usr/lib64/konqueror/policies/managed"
)

for dir in "${CHROMIUM_DIRS[@]}"; do
    if [ -d "$(dirname "$dir")" ] && [ -f "$CHROME" ]; then
        mkdir -p "$dir"
        cp -f "$CHROME" "$dir/policies.json"
        echo "Applied Chrome policies to $dir"
    fi
done
HOOK

sudo chmod +x "$HOOK_SCRIPT"

sudo dnf install -y libdnf5-plugin-actions
sudo mkdir -p /etc/dnf/libdnf5-plugins/actions.d/

ACTIONS_DIR="/etc/dnf/libdnf5-plugins/actions.d"

for pkg in "${!FIREFOX_BROWSERS[@]}" "${!CHROME_BROWSERS[@]}"; do
    echo "post_transaction:$pkg:in::$HOOK_SCRIPT" \
        | sudo tee "$ACTIONS_DIR/${pkg}.actions" > /dev/null
done

echo ""
echo "Setup complete. Created $(ls "$ACTIONS_DIR"/*.actions 2>/dev/null | wc -l) action rules."
echo "Hook script: $HOOK_SCRIPT"
echo ""
echo "Supported browsers:"
echo "  Firefox-based: ${!FIREFOX_BROWSERS[*]}"
echo "  Chrome-based:  ${!CHROME_BROWSERS[*]}"
echo ""
echo "Test with: sudo dnf reinstall <browser-package>"
