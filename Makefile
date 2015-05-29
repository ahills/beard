PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man
CONFDIR = /etc/conf.d
INITDIR = /etc/init.d
RUNDIR = /var/run
DESTDIR =

all: install openrc

install: beard beard.8
	mkdir -p $(DESTDIR)$(PREFIX)/sbin && \
		cp beard $(DESTDIR)$(PREFIX)/sbin && \
		chmod 755 $(DESTDIR)$(PREFIX)/sbin/beard
	mkdir -p $(DESTDIR)$(MANPREFIX)/man8 && \
		cp beard.8 $(DESTDIR)$(MANPREFIX)/man8/beard.8 && \
		chmod 644 $(DESTDIR)$(MANPREFIX)/man8/beard.8

openrc: beard.init beard.conf
	cp beard.init $(DESTDIR)$(INITDIR)/beard && \
		chmod 755 $(DESTDIR)$(INITDIR)/beard
	cp beard.conf $(DESTDIR)$(CONFDIR)/beard && \
		chmod 644 $(DESTDIR)$(CONFDIR)/beard

beard.init: beard.init.in
	sed -e 's#%%PREFIX%%#$(PREFIX)#g' \
		-e 's#%%RUNDIR%%#$(RUNDIR)#g' \
		$^ > $@
