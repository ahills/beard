# The Bear Hibernation Daemon

`beard` is a simple hibernation daemon. By default, it will check the
information in `/sys/class/power_supply/BAT0` every three minutes and run
`/usr/bin/pm-hibernate` when the remaining energy in the battery falls to 3% of
its full capacity or below. A battery check can be triggered by sending the
`HUP` signal to the process.

## Installation

`beard` comes with an executable daemon, a man page, and OpenRC service files
(for `conf.d` and `init.d`). To install just the daemon and its manual to the
default location (`/usr/local`), run:
```
$ make install
```

### Controling Make

| Make Variable | Default Value        | Effect                               |
| ------------- | -------------------- | ------------------------------------ |
| `$PREFIX`     | `/usr/local`         | Root for entire installation         |
| `$MANPREFIX`  | `$PREFIX/share/man`  | Destination for manual               |
| `$CONFDIR`    | `$PREFIX/etc/conf.d` | Destination for OpenRC configuration |
| `$INITDIR`    | `$PREFIX/etc/init.d` | Destination for OpenRC service file  |
| `$RUNDIR`     | `/run`               | Location for writing PID file        |

### Examples

To install the daemon, its manual, and the OpenRC service files to the core
system:
```
$ make PREFIX=/usr CONFDIR=/etc/conf.d INITDIR=/etc/init.d
```

To install only the OpenRC service files, and direct the PID file in `/var/tmp`:
```
$ make openrc PREFIX=/ RUNDIR=/var/tmp
```

## Configuration

`beard` is configured via environment variables and the command line,
preferring the latter. The following table lists the environment variable
with its corresponding command line option, default value, and effect.

| Environment Variable | Command Line Option | Default Value                  | Effect                     |
| -------------------- | ------------------- | ------------------------------ | -------------------------- |
| `$BEARD_HIBERNATE`   | `-H <command>`      | `/usr/bin/pm-hibernate`        | Hibernation command        |
| `$BEARD_PIDFILE`     | `-p <file>`         | none                           | PID file path              |
| `$BEARD_PERIOD`      | `-P <seconds>`      | 180                            | Sleep time between checks  |
| `$BEARD_SUPPLY`      | `-s <directory>`    | `/sys/class/power_supply/BAT0` | Power supply path          |
| `$BEARD_THRESHOLD`   | `-t <percent>`      | 3                              | Battery critical threshold |

The power supply directory should contain the (virtual) files `present`,
`status`, `energy_now`, and `energy_full`.

Copyright © 2015-2016 Andrew Hills. See LICENSE for details.
