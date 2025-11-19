# all.inc.mk

# Sets `all` as the first target, causing it to require the ALL_TARGET target.
###

.PHONY: all
all: $(ALL_TARGET) ## Synonym for $(ALL_TARGET)
	@:
