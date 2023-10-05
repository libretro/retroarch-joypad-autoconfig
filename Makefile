PREFIX := /usr
INSTALLDIR := $(PREFIX)/share/libretro/autoconfig
DOC_DIR := $(PREFIX)/share/doc/retroarch-joypad-autoconfig

all:
	@echo "Nothing to make for retroarch-joypad-autoconfig."

install:
	for driver in android dinput hid linuxraw mfi parport qnx sdl2 udev x xinput; do \
		for file in $$driver/*.cfg; do \
			install -Dm644 -t $(DESTDIR)$(INSTALLDIR)/$$driver "$$file"; \
		done \
	done
	install -Dm644 -t $(DESTDIR)$(DOC_DIR) COPYING README.md retropad_layout.png

test-install: all
	DESTDIR=/tmp/build $(MAKE) install

test:
	ruby .verify_duplicate_profiles.rb