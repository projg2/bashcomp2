PREFIX = /usr
DATAROOTDIR = $(PREFIX)/share
ESELECTDIR = $(DATAROOTDIR)/eselect/modules
MANDIR = $(DATAROOTDIR)/man
MAN5DIR = $(MANDIR)/man5

all:

clean:
distclean:

install:
	install -m755 -d $(DESTDIR)$(ESELECTDIR) $(DESTDIR)$(MAN5DIR)
	install -m644 bashcomp.eselect $(DESTDIR)$(ESELECTDIR)/
	install -m644 bashcomp.eselect.5 $(DESTDIR)$(MAN5DIR)/

.PHONY: all clean distclean install
