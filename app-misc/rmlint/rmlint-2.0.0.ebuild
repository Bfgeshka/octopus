# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit

DESCRIPTION="rmlint is a commandline tool to clean your filesystem from various sort of lint (unused files, twins, etc.)."
HOMEPAGE="https://github.com/sahib/rmlint"
SRC_URI="https://github.com/sahib/${PN}/archive/v${PV}.tar.gz"

LICENSE=""
SLOT="0"
# That's where the author says it works on:
KEYWORDS="~amd64 ~amd64-linux ~ia64 ~ia64-linux ~x86 ~x86-linux ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
