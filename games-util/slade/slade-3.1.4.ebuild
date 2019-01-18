# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

WX_GTK_VER="3.0-gtk3"

inherit cmake-utils wxwidgets

DESCRIPTION="It's a Doom editor"
HOMEPAGE="http://slade.mancubus.net/"
SRC_URI="https://github.com/sirjuddington/SLADE/archive/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="webkit sfml-renderwindow +fluidsynth"

RDEPEND="
	x11-libs/wxGTK:${WX_GTK_VER}[opengl,gstreamer,webkit?]
	fluidsynth? ( >=media-sound/fluidsynth-1.1.3 )
	>=media-libs/libsfml-2.4.2
	media-libs/freeimage
	media-libs/ftgl
	net-misc/curl
	app-arch/bzip2
	media-libs/glew:*"

DEPEND="
	${RDEPEND}
	app-arch/zip"

S="${WORKDIR}/SLADE-${PV}"

src_prepare()
{
	sed -ie "s:wxStandardPaths\:\:Get().GetDataDir();:\"/usr/share/${PN}\";:" src/Application/App.cpp || die
	default
}

src_configure() {
	need-wxwidgets unicode

	local mycmakeargs=(
		-DNO_WEBVIEW="$(usex !webkit)"
		-DUSE_SFML_RENDERWINDOW="$(usex sfml-renderwindow)"
		-DNO_FLUIDSYNTH="$(usex !fluidsynth)"
	)

	cmake-utils_src_configure
}

src_install() {
	# Binary. (Why such a weird directory? o.O)
	dobin "${WORKDIR}/${P}_build/${PN}" || die "Couldn't install the binary!"

	# Create and install slade.pk3.
	cd "${S}/dist/res"
	zip -r slade.pk3 .
	insinto "/usr/share/${PN}"
	doins slade.pk3 || die "Couldn't install slade.pk3!"

	# Make a desktop entry.
	newicon "${S}/dist/res/logo_icon.png" "${PN}.png"
	make_desktop_entry "${PN}" "SLADE" "${PN}" "Game;Development;IDE"
}
