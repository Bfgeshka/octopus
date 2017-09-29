#octopus

My gentoo overlay for more up-to-date ebuilds and for some interesting packages.

## Installation:
#### Paludis
`/etc/paludis/repositories/octopus.conf`

```
location = /var/db/paludis/repositories/octopus
sync = https://github.com/Bfgeshka/octopus.git
format = e
names_cache = ${location}/.cache/names
write_cache = /var/cache/paludis/metadata
```

#### Portage
~~Manual installation via layman~~
```
layman -a octopus
```

## notable things:
```
asciiquarium
rmlint
fork of `lemonbar` with XFT support
ebuilds for browser Palemoon
actual git version for htop
actual git version for fish
custom patchset for dwm
```
