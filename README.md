octopus
=======
My gentoo overlay.

Installation:
=======
# Paludis
>[/etc/paludis/repositories/octopus.conf]

location = /var/db/paludis/repositories/octopus
sync = git://github.com/Bfgeshka/octopus.git
format = e
names_cache = ${location}/.cache/names
write_cache = /var/cache/paludis/metadata

# Layman
Information is located at http://wiki.gentoo.org/wiki/Layman#Adding_custom_overlays
