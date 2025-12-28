#!/usr/bin/env sh

echo "FROM ZK"

cd "$ZK_NOTEBOOK_DIR" || exit 1
echo "INSIDE ZK"

[ -x "$ZK_NOTEBOOK_DIR/fix-links.sh" ] && "$ZK_NOTEBOOK_DIR/fix-links.sh"

now="$(date '+%Y-%m-%d %H:%M:%S')"
msg="[zk] weekly snapshot – $now"
if [ -n "$1" ]; then
  msg="$msg - $1"
fi

echo "[$now] Starting backup..."
git add .
git commit -m "$msg"
git push
echo "[$now] Backup complete."
