# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit scons-utils eutils git-2

DESCRIPTION="commandline tool to clean your filesystem from various sort of lint (unused files, twins, etc.)."
HOMEPAGE="https://github.com/sahib/rmlint"
SRC_URI=""
EGIT_REPO_URI="https://github.com/sahib/rmlint.git"
EGIT_BRANCH="master"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		dev-util/scons
		dev-python/sphinx
		sys-devel/gettext"

src_compile(){
	escons CC="$(tc-getCC)"
}

src_install() {
#	escons DEBUG=1 LIBDIR=/usr/$(get_libdir) --prefix=/usr  install
	escons install LIBDIR=/usr/$(get_libdir) --prefix="${ED}"/usr
}
