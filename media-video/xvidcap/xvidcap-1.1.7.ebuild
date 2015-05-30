# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/laptop-mode-tools/laptop-mode-tools-1.55-r2.ebuild,v 1.1 2011/07/12 20:41:51 robbat2 Exp $

EAPI=2
inherit eutils

MY_P=${PN}-${PV}

DESCRIPTION="xvidcap is a screen capture enabling you to capture videos off
yourX-Window desktop for illustration or documentation purposes.It is intended
to be a standards-based alternative to tools like Lotus ScreenCam."
HOMEPAGE="http://sourceforge.net/projects/xvidcap/"
SRC_URI="http://sourceforge.net/projects/xvidcap/files/xvidcap/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+X"

RDEPEND="media-video/ffmpeg
         x11-base/xorg-server"
DEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() { :; }

src_install() {
	dodoc NEWS README || die
}
