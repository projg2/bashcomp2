VERSION = 2.0.3
PKG = bashcomp-$(VERSION)

PREFIX = /usr
DATAROOTDIR = $(PREFIX)/share
ESELECTDIR = $(DATAROOTDIR)/eselect/modules
MANDIR = $(DATAROOTDIR)/man
MAN5DIR = $(MANDIR)/man5

PATCH = bash-completion-blacklist-support.patch

all:

clean:
	rm -f $(PATCH)
distclean: clean

$(PATCH): upstream-bash-completion/bash_completion
	( cd upstream-bash-completion && git diff master ) > $@

dist: $(PATCH)
	rm -rf $(PKG)
	install -m755 -d $(PKG)
	install -m644 bashcomp.eselect bashcomp.eselect.5 $(PATCH) $(PKG)/
	tar -c $(PKG) | gzip -9 > $(PKG).tar.gz
	rm -rf $(PKG)

install:
	install -m755 -d $(DESTDIR)$(ESELECTDIR) $(DESTDIR)$(MAN5DIR)
	install -m644 bashcomp.eselect $(DESTDIR)$(ESELECTDIR)/
	install -m644 bashcomp.eselect.5 $(DESTDIR)$(MAN5DIR)/

.PHONY: all clean dist distclean install patch
