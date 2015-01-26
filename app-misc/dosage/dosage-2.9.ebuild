# Distributed under the terms of the GNU General Public License v2
# Xavier Maillard (zedek@gnu.org)

inherit toolchain-funcs distutils

DESCRIPTION="Dosage is an application designed to keep a local mirror of specific web comics"
HOMEPAGE="http://slipgate.za.net/dosage/"
SRC_URI="http://dosage.sourcearchive.com/downloads/2.9-1/dosage_2.9.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
# RDEPEND=">=virtual/python-2.3"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	einfo "Nothing to be compiled."
}

src_install() {
	distutils_src_install

	DDOCS="changelog COPYING README"
	for doc in ${DDOCS}; do
		[ -s "$doc" ] && dodoc doc/$doc
	done

	[ -n "${DOCS}" ] && dodoc doc/${DOCS}
	doman doc/*.1
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/dosage
	einfo "Please consult the README file included on the man page."
	einfo "Dosage has is now executed through mainline"
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
