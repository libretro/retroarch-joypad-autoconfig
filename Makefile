PREFIX := /usr
INSTALLDIR := $(PREFIX)/share/libretro/autoconfig

all:
	@echo "Nothing to make for retroarch-joypad-autoconfig."

install:
	mkdir -p $(DESTDIR)$(INSTALLDIR)
	cp -ar * $(DESTDIR)$(INSTALLDIR)
	rm -rf $(DESTDIR)$(INSTALLDIR)/Makefile \
		$(DESTDIR)$(INSTALLDIR)/configure

test-install: all
	DESTDIR=/tmp/build $(MAKE) install
