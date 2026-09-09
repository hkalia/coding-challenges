# coding-challenges

Solutions and a local test harness for practice problems, in Python and Java.

Versions are pinned to match LeetCode's judge: **Python 3.14** and **JDK 25**.

## Setup

```sh
brew install openjdk@25 watchexec
make bootstrap
```

`bootstrap` runs `uv sync` (creating `.venv/`) and downloads the JUnit console
jar into `tools/`. No sudo and no symlink into `/Library/Java` is needed: the
scripts find Homebrew's keg-only JDK 25 directly.

Optional, and worth it. Add to `~/.zshrc` so you can run make from anywhere in
the repo and have it know which problem you are in:

```sh
lc() {
  local root
  root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    echo "lc: not inside a git repository" >&2; return 1
  }
  make -C "$root" FROM="$PWD" "$@"
}
```

## Daily loop

```sh
make new ID=1450 SLUG=two-sum NAME=twoSum L=java   # L is required: py, java, or both
cd leetcode/1450-two-sum
lc t                                        # run this problem's tests
lc w                                        # re-run them on every save
```

From the repo root without the helper, pass `P=` instead:

```sh
make t P=1450
make test          # everything, both languages
```

`make help` lists every target.

## Layout

```
leetcode/
  _common/
    python/lc.py                 TreeNode, ListNode, builders
    java/lccommon/               same, for Java
  1450-number-of-students.../
    NOTES.md                     problem link, approach, complexity
    conftest.py                  puts python/src and _common on sys.path
    python/src/busy_student.py   solution
    python/src/test_busy_student.py
    java/p1450/Solution.java     solution
    java/p1450/SolutionTest.java
```

Conventions:

- **Directory** is `<problem number>-<leetcode slug>`. No difficulty letter: it
  is the least useful sort key and goes stale when LeetCode reclassifies.
- **Python module** is named after the LeetCode method in snake_case
  (`busyStudent` becomes `busy_student.py`), so the name is short and the tests
  read well.
- **Java package** is `p<number>`. The package directory is not optional: it is
  what stops VS Code's Java language server from seeing hundreds of duplicate
  `Solution` classes once you have solved a few problems.
- Paste to LeetCode by deleting the `package` line (Java) or the helper import
  (Python), if present.

The helper builders take LeetCode's own notation, so an example pastes in
directly:

```python
TreeNode.from_level_order([3, 9, 20, None, None, 15, 7])
ListNode.of(1, 2, 3)
```

```java
TreeNode.fromLevelOrder(3, 9, 20, null, null, 15, 7);
ListNode.of(1, 2, 3);
```

## How the harness works

**Python** runs under pytest with `--import-mode=importlib`, so two problems can
both have a `test_two_sum.py` without colliding. Because that mode does not
touch `sys.path`, each problem carries a three-line `conftest.py` that adds its
own `python/src` and the shared helpers. `make new` generates it. Existing
`unittest.TestCase` classes run unchanged.

**Java** has no build system on purpose. `scripts/jtest.sh` compiles one problem
directory plus `_common` with JDK 25's `javac` and runs it through the JUnit
Platform Console Standalone jar. Compiling one directory is O(1) no matter how
many problems accumulate, which is the main reason there is no Maven or Gradle
here. Compile output goes to `build/` and is gitignored.

If you ever want Gradle instead, the swap is a `settings.gradle.kts` that scans
`leetcode/*` and includes each as a subproject, plus a root `build.gradle.kts`
applying the Java plugin and a JDK 25 toolchain. That buys native IDE import at
the cost of a configuration phase that grows with every problem you add.

## Other sites

Only LeetCode is wired up. Sites like Codeforces and CSES are stdin/stdout
rather than method-signature shaped, which needs a different runner (pipe an
`.in` file, diff against an `.out`). That is not built yet.
