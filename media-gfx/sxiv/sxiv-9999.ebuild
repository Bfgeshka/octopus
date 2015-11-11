# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 eutils savedconfig toolchain-funcs

DESCRIPTION="Simple X Image Viewer"
HOMEPAGE="https://github.com/muennich/sxiv"
SRC_URI=""
EGIT_REPO_URI="https://github.com/muennich/sxiv.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
		media-libs/giflib
		media-libs/imlib2[X]
		media-libs/libexif
		x11-libs/libX11
		"
RDEPEND="${DEPEND}"

src_prepare() {
	tc-export CC
	restore_config config.h
	epatch_user
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install

	save_config config.h
}
