octopus
=======
My gentoo overlay for more up-to-date ebuilds than can be founded in portage and for some packages which still not in it.

Installation:
=======
# Paludis
/etc/paludis/repositories/octopus.conf

```
location = /var/db/paludis/repositories/octopus
sync = git://github.com/Bfgeshka/octopus.git
format = e
names_cache = ${location}/.cache/names
write_cache = /var/cache/paludis/metadata
```

# Layman
Information is located at http://wiki.gentoo.org/wiki/Layman#Adding_custom_overlays
