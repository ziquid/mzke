# features/build-noop.inc.mk

# Feature to have an empty build command so no-build workflows can take advantage of features requiring a build step
###
FEATURE_BUILD_NOOP := Y

.PHONY: build b
build b: ## NOOP build
	@:
