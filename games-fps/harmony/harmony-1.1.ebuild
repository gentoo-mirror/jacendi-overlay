# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Harmony is a computer game made by Thomas van der Velden."
HOMEPAGE="http://rabotik.nl/harmony.htm"
SRC_URI="https://github.com/Jacendi/harmony-game/archive/v1.1.tar.gz"

LICENSE="GPL-2"
KEYWORDS="*"
IUSE=""
SLOT="0"

S="${WORKDIR}/harmony-game-1.1"

src_install()
{
	insinto "/usr/share/doom"
	doins harm1.wad || die
}
