# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake toolchain-funcs git-r3

DESCRIPTION="GUI for net-p2p/monero"
HOMEPAGE="https://getmonero.org"
EGIT_REPO_URI="https://github.com/monero-project/${PN}"
EGIT_COMMIT="v${PV}"

LICENSE="NEWLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hw-wallet qrcode unwind password-strength-meter"

COMMON_DEPEND="
	dev-db/lmdb:=
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtdeclarative:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtxmlpatterns:5[qml]
	dev-qt/qtwidgets:5
	dev-libs/boost:=
	dev-libs/openssl:0
	unwind? ( sys-libs/libunwind[lzma] )
	qrcode? (
		dev-qt/qtmultimedia:5
		media-gfx/zbar
	)
	"
DEPEND="${COMMON_DEPEND}
	dev-qt/linguist-tools:5"
RDEPEND="${COMMON_DEPEND}
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtgraphicaleffects:5
	media-fonts/fontawesome"

PATCHES=(
	"${FILESDIR}/monero-0.17.1.3-linkjobs.patch"
	"${FILESDIR}/monero-0.17.1.9-no-git.patch"
	#"${FILESDIR}/monero-0.17.2.0-boost-176.patch"
	"${FILESDIR}/monero-gui-0.17.2.2-linkjobs.patch"
	"${FILESDIR}/monero-gui-0.17.2.2-no-git.patch"
)

src_configure () {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DMANUAL_SUBMODULES=ON
		-DUSE_DEVICE_TREZOR=$(usex hw-wallet)
		-DENABLE_PASS_STRENGTH_METER=$(usex password-strength-meter)
		-DWITH_SCANNER=$(usex qrcode)
	)
	cmake_src_configure
}

src_compile () {
	emake -C src/zxcvbn-c

	CMAKE_USE_DIR="${WORKDIR}/monero-gui-${PV}"
	BUILD_DIR="${WORKDIR}/monero-gui-${PV}_build"
	cmake_src_compile
}

src_install() {
	cd "${WORKDIR}/monero-gui-${PV}_build"
	dobin bin/monero-wallet-gui
}
