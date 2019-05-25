PREFIX = /usr
DATAROOTDIR = $(PREFIX)/share
ESELECTDIR = $(DATAROOTDIR)/eselect/modules
MANDIR = $(DATAROOTDIR)/man
MAN5DIR = $(MANDIR)/man5

PATCH = bash-completion-blacklist-support.patch

all: $(PATCH)

clean:
	rm -f $(PATCH)
distclean: clean

$(PATCH): upstream-bash-completion/bash_completion
	( cd upstream-bash-completion && git diff master ) > $@

install:
	install -m755 -d $(DESTDIR)$(ESELECTDIR) $(DESTDIR)$(MAN5DIR)
	install -m644 bashcomp.eselect $(DESTDIR)$(ESELECTDIR)/
	install -m644 bashcomp.eselect.5 $(DESTDIR)$(MAN5DIR)/

.PHONY: all clean distclean install patch
