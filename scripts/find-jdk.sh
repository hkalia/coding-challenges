#!/usr/bin/env bash
# Print JAVA_HOME for JDK 25. Checks Homebrew's keg-only paths directly so no
# sudo symlink into /Library/Java/JavaVirtualMachines is needed.
set -euo pipefail
for p in \
  /usr/local/opt/openjdk@25/libexec/openjdk.jdk/Contents/Home \
  /opt/homebrew/opt/openjdk@25/libexec/openjdk.jdk/Contents/Home ; do
  if [[ -x "$p/bin/javac" ]]; then echo "$p"; exit 0; fi
done
if h="$(/usr/libexec/java_home -v 25 2>/dev/null)"; then echo "$h"; exit 0; fi
echo "JDK 25 not found. Run: brew install openjdk@25" >&2
exit 1
