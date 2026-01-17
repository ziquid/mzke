# features/tarball.inc.mk

# Package the source as a tarball.
###
FEATURE_TARBALL := Y

TAR_EXCLUDE_MAC_METADATA := $(if $(IS_MAC),--no-mac-metadata,)

.PHONY: package pack p tarball tar tb
package pack p tarball tar tb: build ## Create the $(APP)-source.tgz package.  Implies build.
	tar cz --no-xattrs $(TAR_EXCLUDE_MAC_METADATA) --exclude-vcs -C .. --exclude $(APP)-source.tgz --exclude $(APP).tgz -f $(APP)-source.tgz $(APP)

ifdef FEATURE_LOCAL_INSTALL
.PHONY: pack-install-global pack-install pig pi
pack-install-global pack-install pig pi: install

.PHONY: prig
prig: pig ## alias for pig
	@:
endif
