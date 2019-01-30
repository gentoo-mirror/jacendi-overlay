# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

MY_P="entityx-${PV}"

DESCRIPTION="A fast, type-safe C++ Entity Component System"
HOMEPAGE="https://github.com/alecthomas/entityx"
SRC_URI="https://github.com/alecthomas/entityx/archive/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_configure() {
	local mycmakeargs=(
		-DENTITYX_BUILD_TESTING=false
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	insinto /usr/share/cmake/Modules
	doins cmake/FindEntityX.cmake
}
