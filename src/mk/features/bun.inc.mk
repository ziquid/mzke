# features/bun.inc.mk

# Bun package management and script execution
#
# Features:
# - package-install-global pig: Installs the built package globally
#   - Depends on: package pack p (ensures tarball is created first)
#   - Uses: BUN_PACKAGE_NAME and BUN_PACKAGE_VERSION variables
#   - Command: bun install -g /absolute/path/to/package-name-version.tgz
###
FEATURE_BUN := Y

# Package variables
BUN_PACKAGE_NAME := $(shell jq -r '.name' package.json)
BUN_PACKAGE_VERSION := $(shell jq -r '.version' package.json)
BUN_PACKAGE_NAME_STRIPPED := $(shell echo '$(BUN_PACKAGE_NAME)' | sed 's/@//g' | tr '/' '-')
BUN_PACKAGE_NAME_VERSION := $(BUN_PACKAGE_NAME_STRIPPED)-$(BUN_PACKAGE_VERSION)
BUN_PACKAGE_TARBALL := $(BUN_PACKAGE_NAME_VERSION).tgz

# Main targets
.PHONY: install i
install i: ## Install bun dependencies
	bun install $($@_ARGS)

.PHONY: install-global ig
install-global ig: ## Install a bun package globally
	bun install -g $($@_ARGS)

.PHONY: npm-login
npm-login: ## Login to NPM registry (uses npm login)
	npm login $($@_ARGS)

.PHONY: package pack p
package pack p: build ## Create the $(BUN_PACKAGE_TARBALL) package.  Implies build.
	bun pm pack $($@_ARGS)

.PHONY: package-install-global pig
package-install-global pig: package ## Install the $(BUN_PACKAGE_NAME_VERSION) package globally.  Implies package.
	bun install -g $(shell pwd -P)/$(BUN_PACKAGE_TARBALL)

.PHONY: publish pub
publish pub: ## Publish the $(BUN_PACKAGE_NAME_VERSION) package to registry
	bun publish $($@_ARGS)

.PHONY: run r
run r: ## Run a bun script
	bun run $($@_ARGS)

.PHONY: start st s
start st s: ## Run 'bun start' with optional arguments
	bun start $($@_ARGS)

.PHONY: run-dev rd
run-dev rd: ## Run 'bun run dev' for development mode
	bun run dev $($@_ARGS)

.PHONY: build b
build b: ## Build the $(BUN_PACKAGE_NAME_STRIPPED) project (tries 'bun run build' first, then 'bun build')
	$(eval BUILD_CMD := $(shell jq -e '.scripts.build' package.json > /dev/null 2>&1 && echo 'bun run build' || echo 'bun build'))
	$(BUILD_CMD) $($@_ARGS)

.PHONY: test t
test t: ## Run bun tests
	bun test $($@_ARGS)
