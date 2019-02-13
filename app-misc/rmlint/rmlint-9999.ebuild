# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit eutils git-r3 python-r1 scons-utils

DESCRIPTION="Tool for cleaning up your filesystem"
HOMEPAGE="https://github.com/sahib/rmlint"
SRC_URI=""
EGIT_REPO_URI="https://github.com/sahib/rmlint.git"
EGIT_BRANCH="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="doc +nls"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="
	dev-libs/elfutils
	>=dev-libs/glib-2.32
	dev-libs/json-glib
	sys-apps/util-linux
	sys-libs/glibc"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	doc? ( dev-python/sphinx )"

src_prepare() {
	
	## Temporary fix
	rm po/fr.po || die "removing of fr.po failed"
	
	eapply_user
}

src_compile() {
	COMP_FLAGS=CC="\"$(tc-getCC)\" --prefix=${D}/usr --actual-prefix=/usr --libdir=/usr/$(get_libdir)"
	if ! use nls; then
		COMP_FLAGS += "--without-gettext"
	fi

	escons "${COMP_FLAGS}"
}

src_install(){
	escons install LIBDIR=/usr/$(get_libdir) --prefix="${ED}"/usr
	rm -f "${D}"/usr/share/glib-2.0/schemas/gschemas.compiled
	if ! use doc; then
		rm -rf "${D}"/usr/share/man
	fi
}
