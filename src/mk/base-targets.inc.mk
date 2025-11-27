# base-targets.inc.mk

# Targets used by mk-includes.  Currently only the required-arg target.
###

required-arg--%: ## target that requires an argument for another target, e.g. required-arg--<target-name>--<message-if-missing>
	$(eval ARG := $(call split,--,$*))
	$(eval FUNC := $(word 1,$(ARG)))
	$(eval MSG := $(subst -, ,$(word 2,$(ARG))))
	$(if $($(FUNC)_ARGS),,$(error Missing parameter for $(FUNC): $(MSG)))
