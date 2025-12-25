FEATURES := local-install

# Local installation entries for mzke
LOCAL_INSTALL_ENTRIES := \
    src/bin/mzke:/usr/local/bin:0755 \
    src/mk/features/*.inc.mk:/usr/local/share/mzke/mk/features:0644 \
    src/mk/*.inc.mk:/usr/local/share/mzke/mk:0644 \
    src/Mzkefile.example:/usr/local/share/mzke:0644 \
    docs/README.md:/usr/local/share/mzke/docs:0644 \
    src/mk/vendor/gmsl/gmsl:/usr/local/share/mzke/mk/vendor/gmsl:0644 \
    src/mk/vendor/gmsl/__gmsl:/usr/local/share/mzke/mk/vendor/gmsl:0644

# Default target
ALL_TARGET := help
