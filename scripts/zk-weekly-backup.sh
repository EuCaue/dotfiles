#!/usr/bin/env sh

cd "$ZK_NOTEBOOK_DIR" || exit 1

now="$(date '+%Y-%m-%d %H:%M:%S')"
msg="[zk] weekly snapshot – $now"

echo "[$now] Starting backup..."
git add .
git commit -m "$msg"
git push
echo "[$now] Backup complete."
