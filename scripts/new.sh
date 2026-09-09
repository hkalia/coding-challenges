#!/usr/bin/env bash
# Scaffold a new problem.
#   scripts/new.sh <id> <slug> <methodName> <py|java|both>
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ID="${1:?usage: new.sh <id> <slug> <methodName> <py|java|both>}"
SLUG="${2:?slug required}"
METHOD="${3:?methodName required (e.g. busyStudent)}"
LANGS="${4:-}"
case "$LANGS" in
  py|java|both) ;;
  "") echo "L is required. Use L=py, L=java, or L=both." >&2; exit 1 ;;
  *)  echo "L must be py, java, or both (got '$LANGS')." >&2; exit 1 ;;
esac

SNAKE="$(printf '%s' "$METHOD" | sed -E 's/([a-z0-9])([A-Z])/\1_\2/g' | tr '[:upper:]' '[:lower:]')"
DIR="$ROOT/leetcode/${ID}-${SLUG}"
PKG="p${ID}"

if [[ -e "$DIR" ]]; then echo "already exists: $DIR" >&2; exit 1; fi
mkdir -p "$DIR"

cat > "$DIR/NOTES.md" <<EOF
# ${ID}. ${SLUG}

https://leetcode.com/problems/${SLUG}/

## Approach

## Complexity
- Time:
- Space:
EOF

# conftest.py: pytest runs in importlib mode and does not touch sys.path,
# so point it at this problem's src and the shared helpers.
cat > "$DIR/conftest.py" <<'EOF'
import sys
from pathlib import Path

HERE = Path(__file__).parent
for _p in (HERE / "python" / "src", HERE.parent / "_common" / "python"):
    _s = str(_p)
    if _p.is_dir() and _s not in sys.path:
        sys.path.insert(0, _s)
EOF

if [[ "$LANGS" == "both" || "$LANGS" == "py" ]]; then
  mkdir -p "$DIR/python/src"
  cat > "$DIR/python/src/${SNAKE}.py" <<EOF
class Solution:
    def ${METHOD}(self):  # TODO paste the real signature from LeetCode
        raise NotImplementedError
EOF
  cat > "$DIR/python/src/test_${SNAKE}.py" <<EOF
import unittest

from ${SNAKE} import Solution


class Test$(printf '%s' "$METHOD" | sed -E 's/^(.)/\U\1/')(unittest.TestCase):
    def setUp(self):
        self.solution = Solution()

    def test_example_1(self):
        self.fail("TODO: add example 1 from the problem")
EOF
fi

if [[ "$LANGS" == "both" || "$LANGS" == "java" ]]; then
  mkdir -p "$DIR/java/$PKG"
  cat > "$DIR/java/$PKG/Solution.java" <<EOF
package ${PKG};

class Solution {
    // TODO paste the real signature from LeetCode
}
EOF
  cat > "$DIR/java/$PKG/SolutionTest.java" <<EOF
package ${PKG};

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class SolutionTest {
    private final Solution solution = new Solution();

    @Test
    void example1() {
        fail("TODO: add example 1 from the problem");
    }
}
EOF
fi

echo "created leetcode/${ID}-${SLUG}"
