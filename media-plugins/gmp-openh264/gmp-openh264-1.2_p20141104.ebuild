# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit nsplugins

DESCRIPTION="Gecko Media Plugin for openh264, to be used in mozilla packages"
HOMEPAGE="http://www.openh264.org/"
SRC_URI="http://dev.gentoo.org/~axs/distfiles/${P}.tar.xz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RESTRICT="bindist"

RDEPEND=""
DEPEND="dev-lang/nasm"

DOCS=( LICENSE CONTRIBUTORS README.md )

src_compile() {
	local mybits="ENABLE64BIT=No"
	case "${ABI}" in
                s390x|alpha|*64) mybits="ENABLE64BIT=Yes";;
	esac
	emake V=Yes ${mybits} plugin
}

src_install() {
	local plugpath="usr/$(get_libdir)/${PLUGINS_DIR}/gmp-${PN/-/}/system-installed"

	insinto /${plugpath}
	doins libgmpopenh264.so gmpopenh264.info
	echo "MOZ_GMP_PATH=\"${EROOT}${plugpath}\"" >"${T}"/98-moz-${PN}
	doenvd "${T}"/98-moz-${PN}
}

pkg_postinst() {
	elog "USE=system-gmps on the mozilla packages will disable the default"
	elog "autoupdates preference for this and other gmp plugins, but it may be"
	elog "overridden in a user's profile (ie, about:config)."
	elog ""
	elog "Also, if a previous mozilla version has already installed gmp-gmpopenh264"
	elog "into a user's profile, that version may take precedence over this package"
	elog "and will need to be removed before the files installed by this package"
	elog "are certain to be used."
	elog ""
	ewarn "You may need to modify each user's .mozilla profile"
	ewarn "by hand, disabling autoupdates in about:config and deleting any"
	ewarn "existing plugin in the profile dir, in order for this package"
	ewarn "to have any effect."
}
