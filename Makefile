all:
	@if [ "x$(PREFIX)" = x ]; then \
		echo "PREFIX must be set."; \
		exit 1; \
	fi

install:
	# Config files
	@mkdir -p $(PREFIX)/share/gnome-doc-utils
	cp gnome-doc-utils.make $(PREFIX)/share/gnome-doc-utils
	cp gnome-doc-utils.m4 $(PREFIX)/share/aclocal

	cat gnome-doc-prepare.in | sed -e 's,@prefix@,$(PREFIX),g' > $(PREFIX)/bin/gnome-doc-prepare
	chmod +x $(PREFIX)/bin/gnome-doc-prepare

	@mkdir -p $(PREFIX)/lib/pkgconfig
	cat gnome-doc-utils.pc.in | sed -e 's,@prefix@,$(PREFIX),g' > $(PREFIX)/lib/pkgconfig/gnome-doc-utils.pc
