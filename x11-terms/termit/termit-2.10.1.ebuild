# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Simple terminal emulator based on vte library, extensible vie Lua"
HOMEPAGE="http://wiki.github.com/nonstop/termit"
SRC_URI="http://github.com/nonstop/${PN}/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-util/cmake-2.6.4-r3"
RDEPEND="x11-libs/vte
	dev-lang/lua
	>=x11-libs/gtk+-2.10"

DOCS="README ChangeLog session.example termit.example"

CMAKE_IN_SOURCE_BUILD="yes"

pkg_postinst() {
	einfo
	einfo "There is a example of configuration file in"
	einfo "         /usr/share/doc/termit/termit.example"
	einfo
}
