# help.inc.mk

# Shows all documented targets from all included Makefiles.
###

ifdef IS_LINUX
  ANSI_ECHO := echo -e
else
  ANSI_ECHO := echo
endif

define HELP_SCRIPT
	@echo "$(MAKE_USER_COMMAND) targets:"; \
	LC_ALL=C $(MAKE_USER_COMMAND) -qp $(addprefix -f ,$(HELP_FILES)) : 2>/dev/null \
	  | awk -v RS= -F: '$$1 ~ /^[^#. ]+$$/ { print $$1 }' \
	  | sort -u \
	  | xargs -I @ grep -E '^@( ?:| [a-zA-Z_ .%-]+:).*?## ' $(HELP_FILES) 2>/dev/null \
	  | sort -u \
	  | while read HELP; do \
			DESC=$$(echo $$HELP | awk -F'## ' '{print $$2}'); \
			if [ -n "$$DESC" ]; then \
				FILE=$$(echo $$HELP | awk -F: '{print $$1}' | sed -e 's,^mk/,,' -e 's,^features/,feat/,' -e 's,\.inc\.mk$$,,'); \
				TARGET=$$(echo $$HELP | awk -F: '{print $$2}'); \
				if [ "$$FILE" != "$$FILE_OLD" ]; then \
					[ "$$FILE_OLD" != "" ] && echo; \
					echo From file: $$FILE; \
					FILE_OLD=$$FILE; \
				fi; \
				VAR=$$(echo $$DESC | grep -o -s '\$$([A-Z_][A-Z0-9_]*)' | head -n 1 | sed -e 's/[$$()]*//g'); \
				if [ -n "$$VAR" ]; then \
					[ 0"$$DEBUG" -ge 2 ] && echo "DEBUG: found variable $$VAR in description"; \
					VAR_VAL=$$($(RUN_MAKE) -s show-val-$$VAR); \
					if [ -n "$$VAR_VAL" ]; then \
						[ 0"$$DEBUG" -ge 2 ] && echo "DEBUG: substituting variable $$VAR with value '$$VAR_VAL' in description"; \
						DESC=$$($(ANSI_ECHO) $$(echo $$DESC | sed -e "s@\$$($${VAR})@\\\033[35m$$VAR_VAL\\\033[0m@g")); \
					fi; \
				fi; \
				printf "\033[36m%-30s\033[0m %s\n" "$$TARGET" "$$DESC"; \
			fi; \
		done
endef

.PHONY: help
help: ## Show help for all enabled targets
	$(eval HELP_FILES := $(MAKEFILE_LIST))
	$(HELP_SCRIPT)

.PHONY: help-all
help-all: ## Show help for all targets, including disabled features
	@echo "$(MAKE_USER_COMMAND) targets (all features):"; \
	grep -H '## ' $(MAKEFILE_LIST) mk/features/*.inc.mk 2>/dev/null \
	  | grep -vE '^\./Mzkefile:|^[^:]+:\s+' \
	  | sed -E 's/^([^:]+):([^:]+):.*## (.*)$$/\1|\2|\3/' \
	  | awk -F'|' '{file=$$1; target=$$2; desc=$$3; gsub(/.*\//, "", file); gsub(/\.inc\.mk$$/, "", file); gsub(/^mk\//, "", file); gsub(/^features\//, "feat/", file); gsub(/^\.[a-zA-Z]+( +|$$)/, "", target); gsub(/^ +| +$$/, "", target); if (target != "") print file "|" target "|" desc}' \
	  | sort -t'|' -k1,1 -k2,2 -u \
	  | awk -F'|' 'BEGIN {last=""} {if ($$1 != last) {if (last != "") print ""; print "From file: " $$1; last=$$1} printf "\033[36m%-30s\033[0m %s\n", $$2, $$3}'

show-var-%: ## Show the value of a make variable.  Usage: make show-var-VARIABLE
	$(info $* = $($*))

show-val-%: ## Show ONLY the value of a make variable.  Usage: make -s show-val-VARIABLE
	$(info $(strip $($*)))

.PHONY: describe-features
describe-features: ## briefly describe the different feature files
	for a in mk/*.inc.mk mk/features/*.inc.mk; do \
	  grep -B10 \#\#\# $$a || head -n 10 $$a; \
	  echo ; echo --- ; \
	done
