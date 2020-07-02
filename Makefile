PREFIX := /usr
INSTALLDIR := $(PREFIX)/share/libretro/autoconfig
DOC_DIR := $(PREFIX)/share/doc/retroarch-joypad-autoconfig

all:
	@echo "Nothing to make for retroarch-joypad-autoconfig."

install:
	for driver in android dinput hid linuxraw parport qnx sdl2 udev x xinput; do \
		install -Dm644 -t $(DESTDIR)$(INSTALLDIR)/$$driver $$driver/*.cfg; \
	done
	install -Dm644 -t $(DESTDIR)$(DOC_DIR) COPYING README.md retropad_layout.png

test-install: all
	DESTDIR=/tmp/build $(MAKE) install
