#!/usr/bin/env bash
set -euo pipefail

REMOTE="origin"
BRANCH="$(git branch --show-current)"

confirm() {
  read -r -p "$1 [y/N] " answer
  [[ "$answer" == "y" || "$answer" == "Y" ]]
}

git fetch "$REMOTE"

if git diff --quiet && git diff --cached --quiet && [ "$(git rev-parse HEAD)" = "$(git rev-parse "${REMOTE}/${BRANCH}")" ]; then
  echo "Already in sync with '${REMOTE}/${BRANCH}'."
  exit 0
fi

echo "This will DISCARD all local commits and changes on '${BRANCH}':"
echo
git log --oneline "${REMOTE}/${BRANCH}..HEAD" || true
git status --short
echo

confirm "Reset '${BRANCH}' to '${REMOTE}/${BRANCH}'?" || exit 0

git reset --hard "${REMOTE}/${BRANCH}"

echo
echo "Done. '${BRANCH}' matches '${REMOTE}/${BRANCH}'."
