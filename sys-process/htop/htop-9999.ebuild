# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="interactive process viewer"
HOMEPAGE="http://htop.sourceforge.net"
EGIT_REPO_URI="https://github.com/hishamhm/htop"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="elibc_FreeBSD kernel_linux openvz unicode vserver"

RDEPEND="sys-libs/ncurses[unicode?]"
DEPEND="${RDEPEND}"

DOCS=( ChangeLog README )

pkg_setup() {
	if use elibc_FreeBSD && ! [[ -f ${ROOT}/proc/stat && -f ${ROOT}/proc/meminfo ]]; then
		eerror
		eerror "htop needs /proc mounted to compile and work, to mount it type"
		eerror "mount -t linprocfs none /proc"
		eerror "or uncomment the example in /etc/fstab"
		eerror
		die "htop needs /proc mounted"
	fi

	if ! has_version sys-process/lsof; then
		ewarn "To use lsof features in htop(what processes are accessing"
		ewarn "what files), you must have sys-process/lsof installed."
	fi
}

src_prepare() {
	./autogen.sh
	sed -i -e '1c\#!'"${EPREFIX}"'/usr/bin/python' \
		scripts/MakeHeader.py || die
}

src_configure() {
	[[ $CBUILD != $CHOST ]] && export ac_cv_file__proc_{meminfo,stat}=yes #328971

	econf \
		$(use_enable openvz) \
		$(use_enable kernel_linux cgroup) \
		$(use_enable vserver) \
		$(use_enable unicode) \
		--enable-taskstats
}
