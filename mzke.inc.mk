FEATURES := local-install

# Local installation entries for mzke
#
# This defines what files get installed when running 'mzke install':
# - src/bin/mzke -> /usr/local/bin/mzke (executable)
# - src/mk/features/*.inc.mk -> /usr/local/share/mzke/mk/features (feature files)
# - src/mk/*.inc.mk -> /usr/local/share/mzke/mk (make includes)
# - src/Mzkefile.example -> /usr/local/share/mzke (example configuration)
# - README.md -> /usr/local/share/mzke (main documentation)
# - src/mk/vendor/gmsl/* -> /usr/local/share/mzke/mk/vendor/gmsl (GMSL library)
#
LOCAL_INSTALL_ENTRIES := \
    src/bin/mzke:/usr/local/bin:0755 \
    src/mk/features/*.inc.mk:/usr/local/share/mzke/mk/features:0644 \
    src/mk/*.inc.mk:/usr/local/share/mzke/mk:0644 \
    src/Mzkefile.example:/usr/local/share/mzke:0644 \
    README.md:/usr/local/share/mzke:0644 \
    src/mk/vendor/gmsl/gmsl:/usr/local/share/mzke/mk/vendor/gmsl:0644 \
    src/mk/vendor/gmsl/__gmsl:/usr/local/share/mzke/mk/vendor/gmsl:0644

# Default target
ALL_TARGET := help

TAR_EXCLUDE_MAC_METADATA := $(if $(IS_MAC),--no-mac-metadata,)

.PHONY: package pack p tarball tar tb
package pack p tarball tar tb: ## package this as a source tarball for installation elsewhere
	tar cz --no-xattrs $(TAR_EXCLUDE_MAC_METADATA) --exclude-vcs -C .. --exclude $(APP).tgz -f $(APP).tgz $(APP)

.PHONY: pack-and-copy
pack-and-copy pac pc: pack ## package, copy to zds-ai project
	cp $(APP).tgz ~/sca/zds-ai
