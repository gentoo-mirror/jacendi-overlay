# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="ZDoom BSP node builder"
HOMEPAGE="http://zdoom.org/"
EGIT_REPO_URI="https://github.com/rheit/zdbsp.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
