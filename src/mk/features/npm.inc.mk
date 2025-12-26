# features/npm.inc.mk
#
# NPM package management and script execution
#
# Features:
# - package-install-global pig: Installs the built package globally
#   - Depends on: package pack p (ensures tarball is created first)
#   - Uses: NPM_PACKAGE_NAME and NPM_PACKAGE_VERSION variables
#   - Command: npm install -g /absolute/path/to/package-name-version.tgz
###
FEATURE_NPM := Y

# Package variables
NPM_PACKAGE_NAME := $(shell jq -r '.name' package.json)
NPM_PACKAGE_VERSION := $(shell jq -r '.version' package.json)
NPM_PACKAGE_NAME_STRIPPED := $(shell echo '$(NPM_PACKAGE_NAME)' | sed 's/@//g' | tr '/' '-')
NPM_PACKAGE_NAME_VERSION := $(NPM_PACKAGE_NAME_STRIPPED)-$(NPM_PACKAGE_VERSION)
NPM_PACKAGE_TARBALL := $(NPM_PACKAGE_NAME_VERSION).tgz

# Main targets
.PHONY: install i
install i: ## Install npm dependencies
	npm install $($@_ARGS)

.PHONY: install-global ig
install-global ig: ## Install npm package globally
	npm install -g $($@_ARGS)

.PHONY: package pack p
package pack p: ## Create the $(NPM_PACKAGE_TARBALL) package
	npm pack $($@_ARGS)

.PHONY: package-install-global pig
package-install-global pig: package ## Install the $(NPM_PACKAGE_NAME_VERSION) package globally.  Implies package.
	npm install -g "$(shell pwd -P)/$(NPM_PACKAGE_TARBALL)"

.PHONY: publish pub
publish pub: ## Publish package to npm registry
	npm publish $($@_ARGS)

.PHONY: run r
run r: ## Run an npm script
	npm run $($@_ARGS)

.PHONY: start st s
start st s: ## Run 'npm start' with optional arguments
	npm start $($@_ARGS)

.PHONY: run-dev rd
run-dev rd: ## Run 'npm run dev' for development mode
	npm run dev $($@_ARGS)

.PHONY: test t
test t: ## Run npm tests
	npm test $($@_ARGS)

# Only add npm-login if bun feature is not enabled (bun already has npm-login)
ifndef FEATURE_BUN
.PHONY: npm-login
npm-login: ## Login to NPM registry
	npm login $($@_ARGS)
endif
