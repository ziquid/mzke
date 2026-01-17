# features/image.inc.mk

# Supports building a Docker image (and optionally pushing it to a container registry)
###
FEATURE_IMAGE := Y

DOCKERFILE ?= Dockerfile

# Set progress format to rawjson for AI agent contexts
ifneq ($(or $(CLAUDE_CODE_ENTRYPOINT),$(ZDS_AI_AGENT_HANDLE)),)
  PROGRESS := --progress plain
endif

# Support for build arguments
ifneq ($(BUILD_ARGS),)
  BUILD_ARGS_FLAGS = $(foreach arg,$(BUILD_ARGS),--build-arg $(arg) )
endif

.PHONY: build-container-image bci
build-container-image bci: $(IMAGE_BUILD_DEPS) $(DOCKERFILE) ddr ## Build and Push All container image(s) built by this app
ifeq ($(IS_PROD),Y)
	$(eval IMAGE_BUILD_PUSH := --push)
	$(eval IMAGE_BUILD_PLATFORMS := --platform linux/amd64,linux/arm64)
else
	$(eval IMAGE_BUILD_PUSH := --load)
	$(info Cowardly refusing to push a non-prod branch to container registry)
endif
	docker buildx use mybuilder
	docker buildx build -f $(DOCKERFILE) $(PROGRESS) $(IMAGE_BUILD_PLATFORMS) $(IMAGE_BUILD_PUSH) $(BUILD_ARGS_FLAGS) -t $(IMAGE) $($@_ARGS) .
