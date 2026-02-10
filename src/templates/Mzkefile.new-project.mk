# create a new mzke-based project

MZKE_ROOT := /usr/local/share/mzke
CURDIR_NAME := $(lastword $(subst /, ,$(CURDIR)))
AIM := $(CURDIR_NAME).inc.mk

# include /usr/local/share/mzke/mk/base.inc.mk

new-project:
	@[ -f $(AIM) ] && mv $(AIM) $(AIM).orig && echo existing $(AIM) copied to $(AIM).orig || :
	@[ -f .env ] && mv .env .env.orig && echo existing .env copied to .env.orig || :
	@[ -f .env.example ] && mv .env.example .env.example.orig && echo existing .env.example copied to .env.example.orig || :
	cp $(MZKE_ROOT)/Mzkefile.example ./Mzkefile
	echo '# $(AIM)' > $(AIM)
	echo >> $(AIM)
	echo FEATURES := >> $(AIM)
	@diff -q $(AIM) $(AIM).orig &>/dev/null && rm $(AIM).orig || :
	[ -L ./mk ] || ln -sf $(MZKE_ROOT)/mk .
	@echo '# .env.example' > .env.example
	@echo >> .env.example
	@echo '# .env' > .env
	@echo >> .env
	@diff -q .env .env.orig &>/dev/null && rm .env.orig || :
	@diff -q .env.example .env.example.orig &>/dev/null && rm .env.example.orig || :
	@grep -qs /\.env .gitignore || echo /.env >> .gitignore
	@grep -qs /\.env\.orig .gitignore || echo /.env.orig >> .gitignore
	@echo ✅ New project creation done!
