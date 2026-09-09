#!/usr/bin/env bash
# Compile and run the JUnit tests for one problem directory.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROBLEM="$1"

JAVA_DIR="$PROBLEM/java"
if [[ ! -d "$JAVA_DIR" ]]; then echo "  (no java/ in $(basename "$PROBLEM"))"; exit 0; fi

JUNIT_JAR="$(ls "$ROOT"/tools/junit-platform-console-standalone-*.jar 2>/dev/null | head -1 || true)"
if [[ -z "$JUNIT_JAR" ]]; then echo "JUnit jar missing. Run: make bootstrap" >&2; exit 1; fi

JAVA_HOME="$("$ROOT/scripts/find-jdk.sh")"; export JAVA_HOME
PATH="$JAVA_HOME/bin:$PATH"; export PATH

COMMON="$ROOT/leetcode/_common/java"
OUT="$ROOT/build/$(basename "$PROBLEM")"
rm -rf "$OUT"; mkdir -p "$OUT"

# @argfile keeps this working on macOS's bash 3.2 (no mapfile)
find "$JAVA_DIR" "$COMMON" -name '*.java' > "$OUT/sources.txt" 2>/dev/null || true
if [[ ! -s "$OUT/sources.txt" ]]; then echo "  (no .java files)"; exit 0; fi

javac -cp "$JUNIT_JAR" -d "$OUT" "@$OUT/sources.txt"
java -jar "$JUNIT_JAR" execute \
  --class-path "$OUT" \
  --scan-class-path "$OUT" \
  --details=tree \
  --disable-banner
