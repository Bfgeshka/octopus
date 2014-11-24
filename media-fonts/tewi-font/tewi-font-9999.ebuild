# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-r3 font

DESCRIPTION="monospace font"
HOMEPAGE="https://github.com/lucy/tewi-font"
EGIT_REPO_URI="git://github.com/lucy/tewi-font"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

# bdf2psf gives warnings like: WARNING: U+0020: no glyph defined
IUSE="bdf pcf"

REQUIRED_USE="( || ( bdf pcf ) )"

DEPEND="
	x11-libs/libX11
	pcf? ( x11-apps/bdftopcf )
"
RDEPEND="${DEPEND}"

src_compile() {
	if use pcf; then emake pcfs; fi
}

src_install() {
	insinto /usr/share/fonts/${PN}
	if use bdf; then
		doins *.bdf
	fi

	if use pcf; then
		doins *.pcf
	fi

	font_src_install
}
