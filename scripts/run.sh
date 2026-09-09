#!/usr/bin/env bash
# Run both languages' tests for one problem.
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROBLEM="$1"; LANG_FILTER="${2:-both}"
NAME="$(basename "$PROBLEM")"
rc=0

if [[ "$LANG_FILTER" == "both" || "$LANG_FILTER" == "py" ]]; then
  if [[ -d "$PROBLEM/python" ]]; then
    echo "== python: $NAME"
    (cd "$ROOT" && uv run pytest "$PROBLEM" -q) || rc=1
  fi
fi
if [[ "$LANG_FILTER" == "both" || "$LANG_FILTER" == "java" ]]; then
  if [[ -d "$PROBLEM/java" ]]; then
    echo "== java: $NAME"
    "$ROOT/scripts/jtest.sh" "$PROBLEM" || rc=1
  fi
fi
exit $rc
