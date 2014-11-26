# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/deluge/deluge-1.3.6.ebuild,v 1.7 2014/08/10 20:36:34 slyfox Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1 eutils systemd

DESCRIPTION="BitTorrent client with a client/server model"
HOMEPAGE="http://deluge-torrent.org/"
SRC_URI="http://download.deluge-torrent.org/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86"
IUSE="geoip gtk libnotify setproctitle sound webinterface"

DEPEND=">=net-libs/rb_libtorrent-0.14.9[python]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-util/intltool"
RDEPEND=">=net-libs/rb_libtorrent-0.14.9[python]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	>=dev-python/twisted-core-8.1[${PYTHON_USEDEP}]
	>=dev-python/twisted-web-8.1[${PYTHON_USEDEP}]
	geoip? ( dev-libs/geoip )
	gtk? (
		sound? ( dev-python/pygame[${PYTHON_USEDEP}] )
		dev-python/pygobject:2[${PYTHON_USEDEP}]
		>=dev-python/pygtk-2.12[${PYTHON_USEDEP}]
		gnome-base/librsvg
		libnotify? ( dev-python/notify-python[${PYTHON_USEDEP}] )
	)
	setproctitle? ( dev-python/setproctitle[${PYTHON_USEDEP}] )
	webinterface? ( dev-python/mako[${PYTHON_USEDEP}] )"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.3.5-disable_libtorrent_internal_copy.patch"
}

src_install() {
	distutils-r1_src_install
	newinitd "${FILESDIR}"/deluged.init deluged
	newconfd "${FILESDIR}"/deluged.conf deluged
	systemd_dounit "${FILESDIR}"/deluged.service
	systemd_dounit "${FILESDIR}"/deluge-web.service
}

pkg_postinst() {
	elog
	elog "If after upgrading it doesn't work, please remove the"
	elog "'~/.config/deluge' directory and try again, but make a backup"
	elog "first!"
	elog
	elog "To start the daemon either run 'deluged' as user"
	elog "or modify /etc/conf.d/deluged and run"
	elog "/etc/init.d/deluged start as root"
	elog "You can still use deluge the old way"
	elog
	elog "For more information look at http://dev.deluge-torrent.org/wiki/Faq"
	elog
}
