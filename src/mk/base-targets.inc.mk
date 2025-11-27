# base-targets.inc.mk

# Targets used by mk-includes.  Currently only the required-arg target.
###

required-arg--%: ## target that requires an argument for another target, e.g. required-arg--<target-name>--<message-if-missing>
	$(eval ARGS := $(call split,--,$*))
	$(eval FUNCTION := $(word 1,$(ARGS)))
	$(eval MESSAGE := $(subst -, ,$(word 2,$(ARGS))))
	$(info variable $(FUNCTION)_ARGS is $($(FUNCTION)_ARGS))
	$(if $($(FUNCTION)_ARGS),,$(error Missing parameter for $(FUNCTION): $(MESSAGE)))
