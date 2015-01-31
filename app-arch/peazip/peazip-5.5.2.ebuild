# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Open Source file and archive manager: flexible, portable, secure, and free as in freedom"
HOMEPAGE="https://code.google.com/p/peazip/"
SRC_URI="mirror://sourceforge/${PN}/${P}.src.zip"

LICENSE="LGPL-3 GPL-2 unRAR LGPL-2.1 GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="kde gnome qt4 gtk"

RESTRICT="mirror"

DEPEND="gtk? ( x11-libs/cairo
            x11-libs/gdk-pixbuf:2
            x11-libs/gtk+:2
            x11-libs/pango
        )
        qt4? (
            dev-qt/qtcore
            dev-qt/qtgui
        )
        !app-arch/peazip-bin
        !app-arch/peazip-bin-qt4
        !app-arch/peazip-bin-gtk"
DEPEND="${RDEPEND}
        qt4? ( dev-qt/qtpascal )"

REQUIRED_USE="^^ ( qt4 gtk )"

QA_PRESTRIPPED="opt/peazip/peazip"

S="${WORKDIR}/${P}.src"


src_prepare(){
    use amd64 && export CPU_TARGET="x86_64" || export CPU_TARGET="i386"
    export lazpath="/usr/share/lazarus"
}

src_compile() {
    if use qt4; then
        ws=qt
        cp --dereference /usr/lib/qt4/libQt4Pas.so "${S}"
    else
        ws=gtk2
    fi

	lazbuild --lazarusdir=/usr/share/lazarus project_peach.lpr --widgetset="${ws}" || die
}

src_install() {
    mkdir -p "${D}/usr/bin/"
    mkdir -p "${D}/opt/peazip/"
    mkdir -p "${D}/usr/share/applications/"
    mkdir -p "${D}/usr/share/icons/hicolor/256x256/apps/"
    rsync -a "${S}/res/" "${D}/opt/peazip/res/"
    install "${S}/peazip" "${D}/opt/peazip"
    install "${S}/FreeDesktop_integration/peazip.desktop" "${D}/usr/share/applications/" --mode=644
    install "${S}/FreeDesktop_integration/peazip.png" "${D}/usr/share/icons/hicolor/256x256/apps/" --mode=644
}
