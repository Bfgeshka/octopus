octopus
=======
My gentoo overlay for more up-to-date ebuilds and for some interesting packages.

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


own changes here:
=======
```
tcsh ebuild is fixed for 6.19.00
trying to keep pf-sources fresh
actual git version for htop
custom patchset for dwm-9999
```
