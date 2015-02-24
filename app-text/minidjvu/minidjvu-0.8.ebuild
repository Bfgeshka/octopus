EAPI=5

inherit eutils

DESCRIPTION="minidjvu is a DjVu encoder for black-and-white images."
HOMEPAGE="http://minidjvu.sourceforge.net/"
SRC_URI="mirror://sourceforge/minidjvu/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

IUSE=""

RDEPEND=""
DEPEND="media-libs/tiff"

src_install() {
    exeinto /usr/bin
    doexe ./bin/.libs/${PN} || die "install failed"
    
    insinto /usr/$(get_libdir)
    dolib.so ./bin/.libs/*.so*

    # links for backwards compatibility
    dosym libminidjvu.so /usr/$(get_libdir)/libminidjvu.so.0

    dodoc README || die "dodoc failed"
    doman doc/${PN}.1 || die "doman failed"
}
