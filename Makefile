PACKAGE=gnome-doc-utils
VERSION=0.10.13-fake2

all:
	@if [ "x$(JHBUILD_PREFIX)" = x ]; then \
		echo "JHBUILD_PREFIX must be set."; \
		exit 1; \
	fi

clean:
	@echo "Nothing to clean."

install:
	@mkdir -p $(JHBUILD_PREFIX)/share/gnome-doc-utils
	cp gnome-doc-utils.make $(JHBUILD_PREFIX)/share/gnome-doc-utils
	cp gnome-doc-utils.m4 $(JHBUILD_PREFIX)/share/aclocal

	cat gnome-doc-prepare.in | sed \
	  -e 's,@PACKAGE@,$(PACKAGE),g' \
	  -e 's,@VERSION@,$(VERSION),g' \
	  -e 's,@prefix@,$(JHBUILD_PREFIX),g' \
	  -e 's,@datarootdir@,$(JHBUILD_PREFIX)/share,g' \
	  -e 's,@datadir@,$(JHBUILD_PREFIX)/share,g' > $(JHBUILD_PREFIX)/bin/gnome-doc-prepare
	chmod +x $(JHBUILD_PREFIX)/bin/gnome-doc-prepare

	cat xml2po.in | sed \
	  -e 's,@prefix@,$(JHBUILD_PREFIX),g' \
	  -e 's,@datarootdir@,$(JHBUILD_PREFIX)/share,g' \
	  -e 's,@datadir@,$(JHBUILD_PREFIX)/share,g' > $(JHBUILD_PREFIX)/bin/xml2po
	chmod +x $(JHBUILD_PREFIX)/bin/xml2po

	@mkdir -p $(JHBUILD_PREFIX)/lib/pkgconfig
	cat gnome-doc-utils.pc.in | sed \
	  -e 's,@prefix@,$(JHBUILD_PREFIX),g' \
	  -e 's,@VERSION@,$(VERSION),g' > $(JHBUILD_PREFIX)/lib/pkgconfig/gnome-doc-utils.pc
	cat xml2po.pc.in | sed \
	  -e 's,@prefix@,$(JHBUILD_PREFIX),g' > $(JHBUILD_PREFIX)/lib/pkgconfig/xml2po.pc
