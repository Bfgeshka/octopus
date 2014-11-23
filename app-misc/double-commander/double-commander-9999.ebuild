# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils subversion

DESCRIPTION="Cross Platform file manager."
HOMEPAGE="http://doublecmd.sourceforge.net/"
ESVN_REPO_URI="svn://svn.code.sf.net/p/doublecmd/code/trunk"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS=""

IUSE="-qt4 gtk2"

RDEPEND=">=dev-lang/lazarus-1
"

DEPEND="${RDEPEND}
	x11-libs/gtk+:2
"

src_prepare(){
    #use qt4 && use gtk2 && die "Select only one flag: 'qt4' or 'gtk2'"
    #! use qt4 && ! use gtk2 && die "Select flag: 'qt4' or 'gtk2'"

    #use qt4 && export lcl="qt" || export lcl="gtk2"
    use amd64 && export CPU_TARGET="x86_64" || export CPU_TARGET="i386"

    export lazpath="/usr/share/lazarus"

    # With QT4 not works... use gtk2
    export lcl="gtk2"

	sed -i 's#$lazbuild #$lazbuild --lazarusdir=/usr/share/lazarus #g' ./build.sh
	sed -i 's#$lazbuild #$lazbuild --lazarusdir=/usr/share/lazarus #g' components/build.sh
	sed -i 's#$lazbuild #$lazbuild --lazarusdir=/usr/share/lazarus #g' plugins/build.sh
}

src_compile(){
	./build.sh beta
}

src_install(){
	diropts -m0755
    dodir /usr/share

	install/linux/install.sh --portable-prefix=build

	doicon -s 48 "${S}/build/doublecmd/doublecmd.png"
	rm "${S}/build/doublecmd/doublecmd.png"

	rsync -a "${S}/build/" "${D}/usr/share/" || die "Unable to copy files"

	dosym ../share/doublecmd/doublecmd /usr/bin/doublecmd

	make_desktop_entry doublecmd "Double Commander" "doublecmd" "Utility;" || die "Failed making desktop entry!"
}
