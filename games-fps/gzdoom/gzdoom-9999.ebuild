# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils git-r3 eutils

DESCRIPTION="Enhanced OpenGL port of the official DOOM source code"
HOMEPAGE="http://www.osnanet.de/c.oelckers/gzdoom/index.html"
EGIT_REPO_URI="https://github.com/coelckers/gzdoom.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_mmx gtk3 fluidsynth kde +system-zlib +system-jpeg +system-bzip2 system-gme"

DEPEND="cpu_flags_x86_mmx? ( dev-lang/nasm )"
RDEPEND="
	media-libs/libsdl2[opengl]
	virtual/glu
	media-libs/openal
	media-libs/flac

	fluidsynth? ( media-sound/fluidsynth )
	gtk3? ( x11-libs/gtk+:3 )

	system-zlib? ( sys-libs/zlib )
	system-bzip2? ( app-arch/bzip2 )
	system-gme? ( media-libs/game-music-emu )
	system-jpeg? ( virtual/jpeg:0 )
	kde? ( kde-apps/kdialog )
	"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_no cpu_flags_x86_mmx ASM)
		$(cmake-utils_use_no gtk3 GTK)
		$(cmake-utils_use_use fluidsynth FLUIDSYNTH)

		$(cmake-utils_useno system-zlib FORCE_INTERNAL_ZLIB)
		$(cmake-utils_useno system-jpeg FORCE_INTERNAL_JPEG)
		$(cmake-utils_useno system-bzip2 FORCE_INTERNAL_BZIP2)
		$(cmake-utils_useno system-gme FORCE_INTERNAL_GME)
	)

	cmake-utils_src_configure
}

src_install() {
	cd "${CMAKE_BUILD_DIR}" || die
	dobin ${PN} || die

	insinto "/usr/share/doom"
	doins ${PN}.pk3
}

pkg_postinst() {
	games_pkg_postinst

	elog "Copy or link wad files into /usr/share/doom/"
	elog
	elog "To play, simply run:"
	elog "   gzdoom"
	elog "See /usr/share/doc/${P}/zdoom.txt.* for more info"
}
