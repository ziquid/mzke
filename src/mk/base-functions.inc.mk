# base-functions.inc.mk

# Functions used by mk-includes.  Currently only the include function itself.
###

# F_INCLUDE_FILES -- include the relevant file(s)
F_INCLUDE_FILES = \
  $(foreach f,$(strip $1), \
    $(call debug2,evaluating $f) \
    $(eval HAS_DASH := $(if $(filter -%,$f),attempt to ,)) \
    $(eval f_tmp := $(patsubst -%,%,$f)) \
    $(call debug2,without leading dash - $(f_tmp)) \
    $(eval f_nospace := $(subst $(SPACE_SUBST),\ ,$(f_tmp))) \
    $(call debug2,spaces replaced - $(f_nospace)) \
    $(eval f_new := $(if $(filter /%,$(f_nospace)),$(f_nospace),mk/$(f_nospace))) \
    $(call debug2,full prefix now $(f_new)) \
    $(call debug,will $(HAS_DASH)include $(f_new).inc.mk) \
    $(if $(HAS_DASH), \
      $(eval -include $(f_new).inc.mk), \
      $(eval include  $(f_new).inc.mk) \
    ) \
  )
