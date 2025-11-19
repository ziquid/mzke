# defaults.inc.mk

# Defaults file.  Forms the basis of vars that can be set in <app-name>.inc.mk.

# To override, copy to <app-name>.inc.mk in project root and edit to taste.
# `cp mk/defaults.inc.mk <app-name>.inc.mk`
###

# App Name, defaults to dir name
APP := $(lastword $(subst /, ,$(CURDIR)))

# Default container name, defaults to app name
CONTAINER_NAME := $(APP)

# Docker Image needed for this app?  Specify which here.
IMAGE :=

# Feature flags.  Will include mk/<feature>.inc.mk and set
FEATURES := # certs docker drupal image traefik

# CERTS, set the domains for local and dev.  Make sure FEATURES or ENV_FEATURES includes "certs".
CERTS_LOCAL_DOMAINS :=
CERTS_DEV_DOMAINS :=

ALL_TARGET := run
