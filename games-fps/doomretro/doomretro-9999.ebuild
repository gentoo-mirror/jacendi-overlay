# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3 eutils

DESCRIPTION="The classic, refined DOOM source port. For Windows PC."
HOMEPAGE="https://www.doomretro.com/"
EGIT_REPO_URI="https://github.com/bradharding/doomretro.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-libs/libsdl2
	media-libs/sdl2-mixer
	media-libs/sdl2-image[png]"

DEPEND="${RDEPEND}"

pkg_postinst()
{
	elog "ATTENTION: Before starting the game, you should set DOOMWADPATH"
	elog "environment variable, that must contain paths to IWAD directories."
	elog
	elog "Otherwise, you will have to start the game with '-iwad <path>' parameter"
}
