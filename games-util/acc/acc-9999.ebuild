# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3 eutils

DESCRIPTION="Action Code Script compiler for HeXen/ZDoom"
HOMEPAGE="http://zdoom.org/"
EGIT_REPO_URI="https://github.com/rheit/acc.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	# Binary
	dobin ${PN} || die
	# Install the bundled *.acs files.
	insinto "/usr/local/share/${PN}"
	doins *.acs || die
}
