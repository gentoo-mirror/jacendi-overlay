# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit cmake-utils wxwidgets git-r3

DESCRIPTION="It's a Doom editor"
HOMEPAGE="http://slade.mancubus.net/"
EGIT_REPO_URI="https://github.com/sirjuddington/SLADE.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/wxGTK:3.0[opengl,gstreamer]
		>=media-libs/libsfml-2.4.2
		media-libs/freeimage
		>=media-sound/fluidsynth-1.1.3
		media-libs/ftgl
		media-libs/glew:*
		media-libs/libmodplug"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DNO_WEBVIEW=ON
	)

	cmake-utils_src_configure
}

src_install() {
	# Binary. (Why such a weird directory? o.O)
	dobin "${WORKDIR}/${P}_build/${PN}" || die "Couldn't install the binary!"

	# Create and install slade.pk3.
	cd "${WORKDIR}/${P}/dist/res"
	zip -r slade.pk3 .
	insinto "/usr/share/${PN}"
	doins slade.pk3 || die "Couldn't install slade.pk3!"

	# Make a desktop entry.
	doicon "${FILESDIR}/${PN}.png"
	make_desktop_entry ${PN} "SLADE"
}
