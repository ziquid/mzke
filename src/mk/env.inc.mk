# env.inc.mk

# Includes variables set in project's `.env` file as Makefile vars.

# Sets these defaults
# can/should be overriden in .env
ENV := local

# NB: don't override FEATURES in .env file, add features per env by setting ENV_FEATURES instead, e.g.:
# (in .env:) ENV_FEATURES=certs # include certs for this env only
###

ifneq (,$(wildcard ./.env))
  include ./.env

  # fix the vars whose value is in double quotes
  ENV_QUOTED_VARS := $(shell grep -E '=".*"' .env | cut -d= -f1)
  $(foreach v,$(ENV_QUOTED_VARS),$(eval $(v) := $(subst ",,$($(v)))))

  DOCKER_RUN_ENV_FILE_SUPPORT := --env-file .env
  export ENV
  FEATURES += $(ENV_FEATURES)
endif
