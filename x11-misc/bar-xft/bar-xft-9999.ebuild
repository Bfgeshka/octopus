# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-r3

#
#	It's a forked version with XFT feature
#	Original bar is placed at
#	https://github.com/LemonBoy/bar
#

DESCRIPTION="patched version of x11-misc/bar."
HOMEPAGE="https://github.com/krypt-n/bar"
EGIT_REPO_URI="https://github.com/krypt-n/bar"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	x11-libs/libxcb
	x11-libs/libXft
	!x11-misc/bar"
RDEPEND="${DEPEND}"

src_compile() {
	emake STRIP=/bin/true
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
