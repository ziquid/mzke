# features/npm.inc.mk

# NPM package management and script execution
###
FEATURE_NPM := Y

# Main targets
.PHONY: install i
install i: ## Install npm dependencies
	npm install $($@_ARGS)

.PHONY: package pack p
package pack p: ## Create a tarball from the package
	npm pack $($@_ARGS)

.PHONY: publish pub
publish pub: ## Publish package to npm registry
	npm publish $($@_ARGS)

.PHONY: run start
run start: ## Run 'npm start' with optional arguments
	npm start $($@_ARGS)

.PHONY: run-dev start-dev rd sd
run-dev start-dev rd sd: ## Run 'npm run dev' for development mode
	npm run dev $($@_ARGS)

.PHONY: test t
test t: ## Run npm tests
	npm test $($@_ARGS)
