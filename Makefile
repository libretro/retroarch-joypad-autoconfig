DESTDIR := /tmp/retroarch-joypad-autoconfig

all:
	@echo "Nothing to make for retroarch-joypad-autoconfig."

install:
	mkdir -p $(DESTDIR)
	cp -ar * $(DESTDIR)
	rm $(DESTDIR)/Makefile
	rm $(DESTDIR)/configure
