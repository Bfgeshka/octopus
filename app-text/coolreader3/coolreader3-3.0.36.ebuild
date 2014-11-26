# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils

if [ "${PV}" == 9999 ]
then
	inherit git
	EGIT_REPO_URI="git://crengine.git.sourceforge.net/gitroot/crengine/crengine"
	SRC_URI=""
else
	SRC_URI="mirror://sourceforge/crengine/CoolReader3/cr3-${PV}/cr3_${PV}.orig.tar.gz"
	S=${WORKDIR}/cr3-${PV}
fi

HYP_ARCH="AlReader2.Hyphen.zip"

DESCRIPTION="CoolReader - reader of eBook files (fb2,epub,htm,rtf,txt)"
HOMEPAGE="http://www.coolreader.org/"
SRC_URI="${SRC_URI}
		 hyphen? ( http://alreader.kms.ru/AlReader/${HYP_ARCH} )"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 +wxwidgets hyphen"

DEPEND="sys-libs/zlib
	media-libs/libpng
	media-libs/jpeg
	media-libs/freetype
	wxwidgets? ( app-admin/eselect-wxwidgets
		>=x11-libs/wxGTK-2.8 )
	qt4? ( x11-libs/qt-core:4
		x11-libs/qt-gui:4 )
	hyphen? ( app-arch/unzip )"
RDEPEND="${DEPEND}
	media-fonts/corefonts"

src_prepare() {
	# fix for amd64
	if use amd64; then
		sed -e 's/unsigned int/unsigned long/g' -i "${S}/crengine/src/lvdocview.cpp" \
		|| die "patching lvdocview.cpp for amd64 failed"
	fi
}

src_configure() {
	CMAKE_USE_DIR="${S}"
	CMAKE_BUILD_TYPE="Release"
	if use qt4 && ! use wxwidgets; then
		mycmakeargs="-D GUI=QT"
	elif use wxwidgets && ! use qt4; then
		. "${ROOT}/var/lib/wxwidgets/current"
		if [[ "${WXCONFIG}" -eq "none" ]]; then
		   	die "The wxGTK profile should be selected!"
		fi
		mycmakeargs="-D GUI=WX"
	else
		die "Only one GUI must be selected"
	fi
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if use hyphen; then
		cd "${WORKDIR}"
		insinto /usr/share/crengine
		find . -name "*hyphen*pdb" -exec \
			doins {} \;
	fi
	dosym ../fonts/corefonts /usr/share/crengine/fonts
}
