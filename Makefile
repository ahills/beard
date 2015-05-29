PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man
CONFDIR = $(PREFIX)/etc/conf.d
INITDIR = $(PREFIX)/etc/init.d
RUNDIR = /run

all: install openrc

install: beard beard.8
	mkdir -p $(PREFIX)/sbin && \
		cp beard $(PREFIX)/sbin && \
		chmod 755 $(PREFIX)/sbin/beard
	mkdir -p $(MANPREFIX)/man8 && \
		cp beard.8 $(MANPREFIX)/man8/beard.8 && \
		chmod 644 $(MANPREFIX)/man8/beard.8

openrc: beard.init beard.conf
	cp beard.init $(INITDIR)/beard && \
		chmod 755 $(INITDIR)/beard
	cp beard.conf $(CONFDIR)/beard && \
		chmod 644 $(CONFDIR)/beard

beard.init: beard.init.in
	sed -e 's#%%PREFIX%%#$(PREFIX)#g' \
		-e 's#%%RUNDIR%%#$(RUNDIR)#g' \
		$^ > $@
