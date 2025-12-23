# features/bun.inc.mk

# Bun package management and script execution
###
FEATURE_BUN := Y

# Main targets
.PHONY: install i
install i: ## Install bun dependencies
	bun install $($@_ARGS)

.PHONY: package pack p
package pack p: ## Create a tarball from the package
	bun pm pack $($@_ARGS)

.PHONY: publish pub
publish pub: ## Publish package to registry
	bun publish $($@_ARGS)

.PHONY: run start
run start: ## Run 'bun start' with optional arguments
	bun start $($@_ARGS)

.PHONY: run-dev start-dev rd sd
run-dev start-dev rd sd: ## Run 'bun run dev' for development mode
	bun run dev $($@_ARGS)

.PHONY: test t
test t: ## Run bun tests
	bun test $($@_ARGS)
