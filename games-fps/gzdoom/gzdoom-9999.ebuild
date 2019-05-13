# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3 eutils

DESCRIPTION="Enhanced OpenGL port of the official DOOM source code"
HOMEPAGE="http://www.osnanet.de/c.oelckers/gzdoom/index.html"
EGIT_REPO_URI="https://github.com/coelckers/gzdoom.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk kde openal +system-zlib +system-jpeg +system-bzip2 +system-asmjit system-gme vulkan"

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
	gtk? ( x11-libs/gtk+:* )
	kde? ( kde-apps/kdialog )
	vulkan? ( media-libs/vulkan-loader dev-util/glslang )"

DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DFORCE_INTERNAL_ASMJIT="$(usex !system-asmjit)"
		-DFORCE_INTERNAL_ZLIB="$(usex !system-zlib)"
		-DFORCE_INTERNAL_JPEG="$(usex !system-jpeg)"
		-DFORCE_INTERNAL_BZIP2="$(usex !system-bzip2)"
		-DFORCE_INTERNAL_GME="$(usex !system-gme)"
		-DHAVE_VULKAN="$(usex !vulkan)"
		-DNO_OPENAL="$(usex !openal)"
		-DNO_GTK="$(usex !gtk)"
	)

	cmake-utils_src_configure
}

src_install() {
	dodoc docs/{*.txt,console*.{css,html}}
	newicon "src/posix/zdoom.xpm" "${PN}.xpm"
	make_desktop_entry "${PN}" "GZDoom" "${PN}" "Game;ActionGame;"

	cd "${BUILD_DIR}" || die
	dobin ${PN} || die

	insinto "/usr/share/doom"
	doins ${PN}.pk3

	insinto "/usr/share/doom/soundfonts"
	doins soundfonts/*.sf2
}

pkg_postinst() {
	elog "Copy or link wad files into /usr/share/doom/ or $HOME/.config/gzdoom/"
	elog
	elog "To play, simply run:"
	elog "   gzdoom"
	elog "See /usr/share/doc/${P}/zdoom.txt.* for more info"

	if use vulkan; then
		elog "Warning: Vulkan renderer is currently experimental!"
		elog "If you wanna enable it, use \"+vid_backend 0\" as command line"
		elog "parameter, or enable it in the GZDoom's config file."
		elog "Set this value to 1 if you wanna switch back to OpenGL renderer."
	fi
}
