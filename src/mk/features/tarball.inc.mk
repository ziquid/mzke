# features/tarball.inc.mk

# Package the source as a tarball.
###
FEATURE_TARBALL := Y

TARBALL_NAME ?= $(APP)
TAR_EXCLUDE_MAC_METADATA := $(if $(IS_MAC),--no-mac-metadata,)

.PHONY: package pack p tarball tar tb
package pack p tarball tar tb: build ## Create the $(TARBALL_NAME)-source.tgz package.  Implies build.
	$(eval TMPFILE := $(shell mktemp))
	@git ls-files --recurse-submodules | \
	  while read a; do \
	    printf $(APP)/%s'\n' $$a; \
	  done > $(TMPFILE)
	tar cz --no-xattrs $(TAR_EXCLUDE_MAC_METADATA) --exclude-vcs --exclude .gitea -C .. --exclude $(APP)/$(APP)-source.tgz --exclude $(APP)/$(APP).tgz --exclude $(APP)/$(TARBALL_NAME)-source.tgz --exclude $(APP)/$(TARBALL_NAME).tgz -f $(TARBALL_NAME)-source.tgz -T $(TMPFILE)
	@rm -f $(TMPFILE)
# 	git archive --format=tar.gz -o $(APP)-source.tgz --prefix $(APP)/ HEAD

ifdef FEATURE_LOCAL_INSTALL
.PHONY: pack-install-global pack-install pig pi
pack-install-global pack-install pig pi: pack install ## pack and install
	@:

.PHONY: prig
prig: pig ## alias for pig
	@:
endif
