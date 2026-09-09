SHELL := /bin/bash
JUNIT_VERSION := 1.12.2
JUNIT_JAR := tools/junit-platform-console-standalone-$(JUNIT_VERSION).jar

# FROM is the caller's cwd, passed by the `cc` shell helper (see README) so that
# `make t` can infer which problem you are working on.
FROM ?= $(CURDIR)
P ?=

.PHONY: help bootstrap t test test-py test-java w new clean

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	  | awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

bootstrap: $(JUNIT_JAR) ## install python deps and fetch the junit jar
	uv sync
	@scripts/find-jdk.sh >/dev/null && echo "JDK 25: $$(scripts/find-jdk.sh)"

$(JUNIT_JAR):
	@mkdir -p tools
	curl -fsSL -o $@ "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/$(JUNIT_VERSION)/junit-platform-console-standalone-$(JUNIT_VERSION).jar"

t: ## test the current problem (P=<fragment>, or inferred from cwd)
	@scripts/run.sh "$$(scripts/resolve.sh "$(P)" "$(FROM)")" both

t-py: ## test the current problem, python only
	@scripts/run.sh "$$(scripts/resolve.sh "$(P)" "$(FROM)")" py

t-java: ## test the current problem, java only
	@scripts/run.sh "$$(scripts/resolve.sh "$(P)" "$(FROM)")" java

w: ## watch the current problem and re-run its tests on save
	@d="$$(scripts/resolve.sh "$(P)" "$(FROM)")"; \
	 echo "watching $$d"; \
	 watchexec -w "$$d" -e py,java --  scripts/run.sh "$$d" both

test: test-py test-java ## run everything

test-py: ## run every python test
	uv run pytest -q

test-java: ## run every java test
	@for d in leetcode/*/; do \
	  [ "$$(basename $$d)" = "_common" ] && continue; \
	  [ -d "$$d/java" ] || continue; \
	  scripts/jtest.sh "$$PWD/$${d%/}" || exit 1; \
	done

# NB: not LANG. That is the locale env var and make imports the environment.
new: ## scaffold a problem: make new ID=1450 SLUG=two-sum NAME=twoSum L=py|java|both
	@scripts/new.sh "$(ID)" "$(SLUG)" "$(NAME)" "$(L)"

clean: ## remove compiled java output
	rm -rf build
