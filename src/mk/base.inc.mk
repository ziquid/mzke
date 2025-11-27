# base.inc.mk

# The file that starts all of ZDS Mzke mk-includes.
# Includes GMSL, base functions, targets, and variables
###
include ~/Documents/Tools/gmsl/gmsl

define SILENT_STATEMENTS
DEBUG := 0
IS_SILENT := Y
endef

$(if $(call set_is_member,s,$(MAKEFLAGS)),$(eval $(SILENT_STATEMENTS)),)

include mk/base-functions.inc.mk
include mk/base-targets.inc.mk
include mk/base-vars.inc.mk
