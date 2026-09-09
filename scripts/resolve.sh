#!/usr/bin/env bash
# Print the absolute path of a problem directory.
#   resolve.sh "1450"        -> match by fragment against leetcode/*
#   resolve.sh "" "$PWD"     -> infer from cwd by walking up
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SPEC="${1:-}"
FROM="${2:-$PWD}"

if [[ -n "$SPEC" ]]; then
  matches="$(find "$ROOT/leetcode" -maxdepth 1 -mindepth 1 -type d -name "*${SPEC}*" ! -name '_common' | sort)"
  n="$(printf '%s' "$matches" | grep -c . || true)"
  if [[ "$n" -eq 0 ]]; then echo "no problem matching '$SPEC'" >&2; exit 1; fi
  if [[ "$n" -gt 1 ]]; then
    { echo "ambiguous '$SPEC', matches:"; printf '%s\n' "$matches"; } >&2; exit 1
  fi
  printf '%s\n' "$matches"; exit 0
fi

d="$(cd "$FROM" 2>/dev/null && pwd)" || { echo "bad path: $FROM" >&2; exit 1; }
while [[ "$d" != "/" ]]; do
  if [[ "$(dirname "$d")" == "$ROOT/leetcode" ]]; then printf '%s\n' "$d"; exit 0; fi
  d="$(dirname "$d")"
done
echo "not inside a problem directory; pass P=<fragment>" >&2
exit 1
