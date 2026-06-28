#!/bin/bash

BASE_FILE="$HOME/.local/share/zen-policies.json"

if [ ! -f "$BASE_FILE" ]; then
    echo "Error: Base file not found at $BASE_FILE"
    exit 1
fi

sudo dnf install -y libdnf5-plugin-actions
sudo mkdir -p /etc/dnf/libdnf5-plugins/actions.d/

RULE="post_transaction:zen-browser:in::cp -f $BASE_FILE /opt/zen/distribution/policies.json"

echo "$RULE" | sudo tee /etc/dnf/libdnf5-plugins/actions.d/zen.actions > /dev/null

echo "Setup completed successfully."
echo "Rule created: $RULE"
echo "Test it with: sudo dnf reinstall zen-browser"
