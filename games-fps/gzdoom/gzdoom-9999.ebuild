# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3 eutils

DESCRIPTION="Enhanced OpenGL port of the official DOOM source code"
HOMEPAGE="http://www.osnanet.de/c.oelckers/gzdoom/index.html"
EGIT_REPO_URI="https://github.com/coelckers/gzdoom.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3 kde openal +system-zlib +system-jpeg +system-bzip2 +system-asmjit system-gme"

RDEPEND="
	media-libs/libsdl2[opengl]
	virtual/glu
	
	openal? ( media-libs/openal media-sound/mpg123 media-libs/libsndfile )
	media-sound/fluidsynth

	system-zlib? ( sys-libs/zlib )
	system-bzip2? ( app-arch/bzip2 )
	system-gme? ( media-libs/game-music-emu )
	system-jpeg? ( virtual/jpeg:0 )
	system-asmjit? ( dev-libs/asmjit )

	gtk3? ( x11-libs/gtk+:3 )
	kde? ( kde-apps/kdialog )
	"

DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DFORCE_INTERNAL_ASMJIT="$(usex system-asmjit no yes)"
		-DFORCE_INTERNAL_ZLIB="$(usex system-zlib no yes)"
		-DFORCE_INTERNAL_JPEG="$(usex system-jpeg no yes)"
		-DFORCE_INTERNAL_BZIP2="$(usex system-bzip2 no yes)"
		-DFORCE_INTERNAL_GME="$(usex system-gme no yes)"
		-DNO_OPENAL="$(usex openal no yes)"
		-DNO_GTK="$(usex gtk3 no yes)"
	)

	cmake-utils_src_configure
}

src_install() {
	dodoc docs/{*.txt,console*.{css,html}}
	newicon "src/posix/zdoom.xpm" "${PN}.xpm"
	make_desktop_entry "${PN}" "GZDoom" "${PN}" "Game;ActionGame;"
	
	cd "${BUILD_DIR}" || die
	dobin ${PN} || die

	insinto "${EPREFIX}/usr/share/doom"
	doins ${PN}.pk3

	insinto "${EPREFIX}/usr/share/doom/soundfonts"
	doins soundfonts/*.sf2
}

pkg_postinst() {
	elog "Copy or link wad files into /usr/share/doom/ or $HOME/.config/gzdoom/"
	elog
	elog "To play, simply run:"
	elog "   gzdoom"
	elog "See /usr/share/doc/${P}/zdoom.txt.* for more info"
}
