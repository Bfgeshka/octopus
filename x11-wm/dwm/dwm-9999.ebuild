# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils savedconfig toolchain-funcs git-r3

DESCRIPTION="a dynamic window manager for X11"
HOMEPAGE="http://dwm.suckless.org/"
EGIT_REPO_URI="git://git.suckless.org/dwm"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="xinerama"

DEPEND="
	x11-libs/libX11
	xinerama? (
		x11-proto/xineramaproto
		x11-libs/libXinerama
	)
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e "s/CFLAGS = -std=c99 -pedantic -Wall -Os/CFLAGS += -std=c99 -pedantic -Wall/" \
		-e "/^LDFLAGS/{s|=|+=|g;s|-s ||g}" \
		-e "s/#XINERAMALIBS =/XINERAMALIBS ?=/" \
		-e "s/#XINERAMAFLAGS =/XINERAMAFLAGS ?=/" \
		-e "s@/usr/X11R6/include@${EPREFIX}/usr/include/X11@" \
		-e "s@/usr/X11R6/lib@${EPREFIX}/usr/lib@" \
		-e "s@-I/usr/include@@" -e "s@-L/usr/lib@@" \
		config.mk || die
	sed -i \
		-e '/@echo CC/d' \
		-e 's|@${CC}|$(CC)|g' \
		Makefile || die

 	for i in ${FILESDIR}/*.diff;do
    	epatch "$i"    
 	done

	restore_config config.h
	epatch_user
}

src_compile() {
	if use xinerama; then
		emake CC=$(tc-getCC) dwm
	else
		emake CC=$(tc-getCC) XINERAMAFLAGS="" XINERAMALIBS="" dwm
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/dwm-session2 dwm

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/dwm.desktop

	dodoc README

	save_config config.h
}

pkg_postinst() {
	einfo "This ebuild has support for user defined configs"
	einfo "Please read this ebuild for more details and re-emerge as needed"
	einfo "if you want to add or remove functionality for ${PN}"
	if ! has_version x11-misc/dmenu; then
		elog "Installing ${PN} without x11-misc/dmenu"
		einfo "To have a menu you can install x11-misc/dmenu"
	fi
	einfo "You can custom status bar by usimg xsetroot:"
	einfo "xsetroot -name \"\`date\` \`uptime | sed 's/.*,//'\`\""
}
