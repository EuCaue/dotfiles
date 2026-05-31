#!/usr/bin/env bash
set -euo pipefail

MAIN_BRANCH="master"
WIP_BRANCH="wip"
REMOTE="origin"

confirm() {
  read -r -p "$1 [y/N] " answer
  [[ "$answer" == "y" || "$answer" == "Y" ]]
}

echo "This will squash '${WIP_BRANCH}' into '${MAIN_BRANCH}' as one commit."
echo

git fetch "$REMOTE"

echo "Changes that will enter the monthly commit:"
git diff --stat "${MAIN_BRANCH}..${WIP_BRANCH}"
echo

git log --oneline "${MAIN_BRANCH}..${WIP_BRANCH}" || true
echo

confirm "Continue?" || exit 0

git checkout "$MAIN_BRANCH"

echo
echo "Applying squash merge..."
git merge --squash "$WIP_BRANCH"

echo
echo "Now write your commit message."
git commit

echo
confirm "Reset '${WIP_BRANCH}' to '${MAIN_BRANCH}' now?" || exit 0

git checkout "$WIP_BRANCH"
git reset --hard "$MAIN_BRANCH"

echo
confirm "Force update remote '${REMOTE}/${WIP_BRANCH}' with --force-with-lease?" || exit 0

git push --force-with-lease "$REMOTE" "$WIP_BRANCH"

echo
echo "Done."
echo "'${MAIN_BRANCH}' has the clean commit."
echo "'${WIP_BRANCH}' is synced with '${MAIN_BRANCH}'."
