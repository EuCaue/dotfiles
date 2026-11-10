#!/usr/bin/env sh
set -eu

VAULT="${ZK_NOTEBOOK_DIR:-$HOME/Documents/zk}"
cd "$VAULT" || exit 1

if [ -x "$VAULT/scripts/fix-cross-dir-links.sh" ]; then
  "$VAULT/scripts/fix-cross-dir-links.sh"
fi

now="$(date '+%Y-%m-%d %H:%M:%S')"
msg="[zk] weekly snapshot - $now"
[ -n "${1:-}" ] && msg="$msg - $1"

if [ "${DRY_RUN:-0}" = "1" ]; then
  git status --short
  echo "dry-run: no commit, no push"
  exit 0
fi

git add -A -- . \
  ':!.sync_*' \
  ':!.nextcloudsync.log' \
  ':!.obsidian/workspace.json' \
  ':!.obsidian/workspace-mobile.json' \
  ':!.trash' \
  ':!.zk/notebook.db'

if git diff --cached --quiet; then
  echo "[$now] nothing to commit"
  exit 0
fi

git commit -m "$msg"
git push
echo "[$now] backup complete"
