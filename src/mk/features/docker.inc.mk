# features/docker.inc.mk

# Enables support for building and managing Docker images
###
FEATURE_DOCKER := Y

CONTAINER_SHELL ?= /bin/bash

ifeq ($(HOST_OS),Darwin)
DOCKER_DAEMON := com.[d]ocker.backend
endif

ifeq ($(HOST_OS),Linux)
DOCKER_DAEMON := [d]ockerd
endif

DOCKER_RUNNING := $(shell ps ax | grep -qs $(DOCKER_DAEMON) && echo Y || echo N)
$(call debug2,DOCKER_RUNNING is $(DOCKER_RUNNING))

DOCKER_INTERACTIVE := $(shell tty -s && echo "-i")

.PHONY: ddr dds start-docker
ddr dds start-docker: ## Start (Run) the docker daemon, if not already started (Currently running: $(DOCKER_RUNNING))
ifeq ($(DOCKER_RUNNING)-$(HOST_OS),N-Darwin)
	@open -a Docker --background
	sleep 5
else
	$(call debug,Docker is running? $(DOCKER_RUNNING))
ifeq ($(DOCKER_RUNNING),N)
	$(error Please start Docker and try again)
endif
endif # N-Darwin

.PHONY: docker
docker: ## Generic 'docker' wrapper
	docker $($@_ARGS)

.PHONY: down
down: ## Stop the docker containers, remove networks
	docker compose down $($@_ARGS)

.PHONY: exec
exec: # run ## exec something in a service
	docker compose exec $($@_ARGS)

.PHONY: logs
logs: ddr docker-compose.yml ## Show container logs for the $(CONTAINER_NAME) container
	docker logs $(CONTAINER_NAME) $($@_ARGS)

.PHONY: slogs
slogs: ddr docker-compose.yml ## Show service logs for the specified container
	docker compose logs $($@_ARGS)

.PHONY: rb rebuild
.SECONDEXPANSION:
rb rebuild: docker-compose.yml $$(CERTS_TARGET) ## Recreate and restart the docker containers
	docker compose up -d --force-recreate

.PHONY: rerun restart rr
.SECONDEXPANSION:
rerun restart rr: docker-compose.yml $$(CERTS_TARGET) ## (Re)start the docker containers
	docker compose restart $($@_ARGS)

# @FIXME: This seems to restart sometimes, even if already running.  Not sure why.
.PHONY: run start up
.SECONDEXPANSION:
run start up: ddr docker-compose.yml $$(CERTS_TARGET) ## Run the docker containers, if already stopped.  Don't restart if running.
	docker compose up -d $($@_ARGS)

.PHONY: run-fg
.SECONDEXPANSION:
run-fg: ddr stop $$(CERTS_TARGET) ## Run the docker containers in the foreground.  Stops any running containers first.
	docker compose up $($@_ARGS)

.PHONY: ssh
ssh: run ## SSH into (exec a shell in) the $(CONTAINER_NAME) container
	docker exec -t $(DOCKER_INTERACTIVE) $(CONTAINER_NAME) $(CONTAINER_SHELL)

.PHONY: bash
bash: run ## exec bash in the $(CONTAINER_NAME) container
	docker exec -t $(DOCKER_INTERACTIVE) $(CONTAINER_NAME) bash

.PHONY: sh shell
sh shell: run ## exec /bin/sh in the $(CONTAINER_NAME) container
	docker exec -t $(DOCKER_INTERACTIVE) $(CONTAINER_NAME) sh

.PHONY: zsh
zsh: run ## exec zsh in the $(CONTAINER_NAME) container
	docker exec -t $(DOCKER_INTERACTIVE) $(CONTAINER_NAME) zsh

.PHONY: status st ls
status st ls: ## Show (all) container status
	docker compose ls $($@_ARGS)

.PHONY: stop
stop: ## Stop the docker containers
	docker compose stop $($@_ARGS)
