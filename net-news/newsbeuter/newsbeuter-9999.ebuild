# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils toolchain-funcs git-2

DESCRIPTION="A RSS/Atom feed reader for the text console"
HOMEPAGE="http://www.newsbeuter.org/index.html"
SRC_URI=""
EGIT_REPO_URI="https://github.com/akrennmair/newsbeuter.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-db/sqlite-3.5
	>=dev-libs/json-c-0.11
	  dev-libs/libxml2
	>=dev-libs/stfl-0.21
	>=net-misc/curl-7.18.0
	"

DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	"

src_prepare()
{
	sed -i 's:-ggdb::' Makefile || die
}

src_configure()
{
	./config.sh || die
}

src_compile()
{
	emake CXX="$(tc-getCXX)" AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)"
}

src_install()
{
	emake prefix="${D}/usr" docdir="${D}/usr/share/doc/${PF}" install
	dodoc AUTHORS CHANGES
}
