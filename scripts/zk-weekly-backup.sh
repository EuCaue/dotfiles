#!/usr/bin/env sh

cd "$ZK_NOTEBOOK_DIR" || exit 1

[ -x "$ZK_NOTEBOOK_DIR/fix-links.sh" ] && "$ZK_NOTEBOOK_DIR/fix-links.sh"

now="$(date '+%Y-%m-%d %H:%M:%S')"
msg="[zk] weekly snapshot – $now"
msg="$msg - $1"

echo "[$now] Starting backup..."
git add .
git commit -m "$msg"
git push
echo "[$now] Backup complete."
