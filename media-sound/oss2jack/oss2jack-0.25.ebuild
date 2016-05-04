# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="oss2jack, a userspace OSS dsp emulation with jack backend"
HOMEPAGE="http://fort.xdas.com/~kor/oss2jack/"
SRC_URI="http://fort.xdas.com/~kor/oss2jack/${PN}-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND="
	>=media-libs/libsamplerate-0.0.15
	>=media-sound/jack-audio-connection-kit-0.99
	>=sys-libs/fusd-kor-1.10-r9"

S="${WORKDIR}/${PN}-${PV}"

src_compile() {
	econf --with-fusd=/usr || die "Failed to configure ${PN}"
	make || die "Failed to compile ${PN}"
}

src_install () {
	dodoc ChangeLog COPYING README
	cd src/oss2jack
	dobin oss2jack
#	doman ${FILESDIR}/oss2jack.1
}

pkg_postinst() {
	einfo "To use oss2jack you need to first start jackd"
	einfo "and then run oss2jack to create the dsp device"
	einfo
}
