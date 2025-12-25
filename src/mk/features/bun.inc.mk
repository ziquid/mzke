# features/bun.inc.mk

# Bun package management and script execution
###
FEATURE_BUN := Y

# Main targets
.PHONY: install i
install i: ## Install bun dependencies
	bun install $($@_ARGS)

.PHONY: install-global ig
install-global ig: ## Install bun package globally
	bun install -g $($@_ARGS)

.PHONY: package pack p
package pack p: ## Create a tarball from the package
	bun pm pack $($@_ARGS)

.PHONY: publish pub
publish pub: ## Publish package to registry
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
build b: ## Build the project (smart: uses 'bun run build' if available, else 'bun build')
	$(eval BUILD_CMD := $(shell jq -e '.scripts.build' package.json > /dev/null 2>&1 && echo 'bun run build' || echo 'bun build'))
	$(BUILD_CMD) $($@_ARGS)

.PHONY: test t
test t: ## Run bun tests
	bun test $($@_ARGS)
