# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev cmake

DESCRIPTION="Support library for the Nitrokey"
HOMEPAGE="https://github.com/Nitrokey/libnitrokey"

MY_COMMIT="b34a473ae3b63adb229760d216a7d8ae7a40cbe9"
# pv_git must be as returned by 'git describe': v3.8-10-ge4b2b91
# is checked in unittest/test_offline.c
pv_git="v3.8-8-gb34a473"
SRC_URI="https://github.com/Nitrokey/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"
KEYWORDS="~amd64"
LICENSE="LGPL-3+"
SLOT="0"
IUSE="doc test udev"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/hidapi:=
	udev? ( virtual/udev )"
DEPEND="
	${RDEPEND}
	test? ( <dev-cpp/catch-3:0 )"
BDEPEND="
	virtual/pkgconfig
	doc? ( app-text/doxygen )
"

PATCHES=(
	"${FILESDIR}/0001-CMakeLists.txt-allow-setting-PROJECT_VERSION_GIT-fro.patch"
	"${FILESDIR}/0002-CMakeLists.txt-fix-project-version_3.8.patch"
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_UDEVRULESDIR="$(get_udevdir)"/rules.d

		# actual hardware tests
		#   1. require a connected Nitrokey
		#   2. may kill data on your Nitrokey
		# hence the main testsuite is disabled
		-DCOMPILE_TESTS=OFF
		-DCOMPILE_OFFLINE_TESTS=$(usex test)

		-DADD_GIT_INFO=OFF
		-DPROJECT_VERSION_GIT="${pv_git}"
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	use doc && cmake_src_compile doc
}

src_install() {
	use doc && dodoc -r "${BUILD_DIR}"/doc
	cmake_src_install
}

pkg_postinst() {
	use udev && udev_reload
}

pkg_postrm() {
	use udev && udev_reload
}
