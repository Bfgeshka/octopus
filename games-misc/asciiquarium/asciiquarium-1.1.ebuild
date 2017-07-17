# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

COMMIT_HASH="8bdb7d441a36a5a9f64b853317a66f9d4a82f08f"
DESCRIPTION="Asciiquarium is an aquarium/sea animation in ASCII art"
HOMEPAGE="http://www.robobunny.com/projects/asciiquarium/html/"
SRC_URI="https://github.com/cmatsuoka/asciiquarium/archive/${COMMIT_HASH}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6
		 dev-perl/Term-Animation[ncurses]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/asciiquarium-${COMMIT_HASH}

src_install()
{
	dodoc README CHANGES
	dobin asciiquarium
}
