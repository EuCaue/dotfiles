#!/usr/bin/env bash
# Runs the same bug-fix task on each model and prints: model, pass|fail|timeout, seconds, cost_usd.
set -u

here=$(cd "$(dirname "$0")" && pwd)
timeout_sec=300
if [[ ${1:-} == --timeout ]]; then
  timeout_sec=$2
  shift 2
fi

models=("$@")
if ((${#models[@]} == 0)); then
  models=(
    opencode-go/claude-haiku-5-5
    opencode-go/deepseek-v4.1-flash
    opencode-go/glm-5.3-flash
    opencode-go/gpt-6-luna
    opencode-go/mimo-v2.6-flash
    opencode-go/minimax-m3.1-flash
    opencode-go/qwen3.8-flash
  )
fi

prompt="Corrija slug.py para os testes em test_slug.py passarem. Não edite os testes."

for model in "${models[@]}"; do
  dir=$(mktemp -d)
  trap 'rm -rf "$dir"' EXIT INT TERM
  cp "$here"/bakeoff-fixture/*.py "$dir"
  start=$(date +%s)
  (cd "$dir" && timeout "$timeout_sec" opencode run --auto --format json -m "$model" "$prompt" >events.jsonl 2>run.err)
  rc=$?
  secs=$(($(date +%s) - start))

  if ((rc == 124)); then
    result=timeout
  elif (cd "$dir" && python3 -m unittest -q >/dev/null 2>&1); then
    result=pass
  else
    result=fail
  fi

  # Cost lives on the exported session, not in the run events.
  session=$(grep -o '"sessionID": *"[^"]*"' "$dir/events.jsonl" | head -1 | cut -d'"' -f4)
  cost=-
  if [[ -n $session ]]; then
    cost=$(cd "$dir" && opencode session export "$session" 2>/dev/null |
      python3 -I -c 'import json,sys; print(json.load(sys.stdin)["info"]["cost"])' 2>/dev/null) || cost=-
  fi

  printf '%s\t%s\t%s\t%s\n' "$model" "$result" "$secs" "${cost:--}"
  rm -rf "$dir"
done
