# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit git-r3 eutils

DESCRIPTION="Converter for Doom and HeXen maps to UDMF"
HOMEPAGE="https://github.com/CO2/UDMF-Convert"
EGIT_REPO_URI="https://github.com/CO2/UDMF-Convert.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/iostream/cstdio/g' mapread.h
}

src_install() {
	dobin *convert || die
}
