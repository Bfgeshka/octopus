# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils autotools git-2 user

DESCRIPTION="Linux program to mount and unmount removable devices without a password"
HOMEPAGE="http://ignorantguru.github.com/udevil/"
EGIT_REPO_URI="git://github.com/IgnorantGuru/udevil.git
	https://github.com/IgnorantGuru/udevil.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=app-shells/bash-4.0
	>=virtual/udev-143
	sys-libs/glibc
	virtual/acl"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	enewgroup plugdev
}

src_prepare() {
	epatch "${FILESDIR}/${P}-flags.patch"
	eautoreconf
}

src_configure() {
	econf \
		--with-setfacl-prog="$(type -P setfacl)"
}

src_install() {
	default
	fowners root:plugdev /usr/bin/udevil
	fperms 4754 /usr/bin/udevil
}

pkg_postinst() {
	echo
	elog "Please add your user to the plugdev group"
	elog "to be able to use ${PN} as a user"
	elog
	elog "Optional dependencies:"
	elog "gnome-extra/zenity (devmon popups)"
	elog "net-fs/cifs-utils  (mounting samba shares)"
	elog "net-fs/curlftpfs   (mounting ftp shares)"
	elog "net-fs/nfs-utils   (mounting nfs shares)"
	elog "sys-fs/sshfs-fuse  (mounting sftp shares)"
	elog "virtual/eject      (eject via devmon)"
	einfo
	if ! has_version 'sys-fs/udisks' ; then
		elog "When using ${PN} without udisks, and without the udisks-daemon running,"
		elog "you may need to enable kernel polling for device media changes to be detected."
		elog "See http://ignorantguru.github.com/${PN}/#polling"
		has_version '<sys-fs/udev-173' && ewarn "You need at least udev-173"
		kernel_is lt 2 6 38 && ewarn "You need at least kernel 2.6.38"
		einfo
	fi
}
