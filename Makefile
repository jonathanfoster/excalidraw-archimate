SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

.PHONY: all
all: help

##@ Available Commands:

.PHONY: help
help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: install-deps
install-deps: ## Install dependencies
	brew install markdownlint-cli

.PHONY: lint
lint: lint-markdown ## Lint all files

.PHONY: lint-markdown
lint-markdown: ## Lint Markdown files
	markdownlint '**/*.md'

.PHONY: pre-commit
pre-commit: lint ## Run pre-commit checks
