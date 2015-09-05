# Distributed under the terms of the GNU General Public License v2
# Xavier Maillard (zedek@gnu.org)

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit toolchain-funcs distutils-r1 eutils

DESCRIPTION="Dosage is an application designed to keep a local mirror of specific web comics"
HOMEPAGE="http://dosage.rocks/"
SRC_URI="https://github.com/wummel/dosage/archive/upstream/${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/dosage-upstream-${PV}

#src_unpack() {
#	unpack ${A}
#	cd ${S}
#}

python_prepare_all() {
	distutils-r1_python_prepare_all
}

# src_install() {
#
#	distutils_src_install
#
#	DDOCS="changelog COPYING README"
#	for doc in ${DDOCS}; do
#		[ -s "$doc" ] && dodoc doc/$doc
#	done
#
#	[ -n "${DOCS}" ] && dodoc doc/${DOCS}
#	doman doc/*.1
#}

python_install_all() {
	distutils-r1_python_install_all
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/dosage
	einfo "Please consult the README file included on the man page."
	einfo "Dosage has is now executed through mainline"
}

# pkg_postrm() {
# 	python_version
# 	python_mod_cleanup
# }
