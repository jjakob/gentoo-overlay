# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake toolchain-funcs

DESCRIPTION="GUI for net-p2p/monero"
HOMEPAGE="https://getmonero.org"
SUBMOD_monero_TAG="ab18fea3500841fc312630d49ed6840b3aedb34d" # v0.17.3.0
SUBMOD_quirc_TAG="7e7ab596e4d0988faf1c12ae89c354b114181c40"
SUBMOD_monero_SUBMOD_miniupnp_TAG="544e6fcc73c5ad9af48a8985c94f0f1d742ef2e0" # v2.2.1
SUBMOD_monero_SUBMOD_RandomX_TAG="9efc398c196ef1c50d8e6f5e1f2c5ac02f1f6ceb"
SUBMOD_monero_SUBMOD_rapidjson_TAG="129d19ba7f496df5e33658527a7158c79b99c21c"
SUBMOD_monero_SUBMOD_supercop_TAG="633500ad8c8759995049ccd022107d1fa8a1bbc9"
SUBMOD_monero_SUBMOD_trezor__common_TAG="bff7fdfe436c727982cc553bdfb29a9021b423b0"
SUBMOD_monero_SUBMOD_unbound_TAG="0f6c0579d66b65f86066e30e7876105ba2775ef4"
SRC_URI="https://github.com/monero-project/monero-gui/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/dlbeer/quirc/archive/${SUBMOD_quirc_TAG}.tar.gz -> monero-gui_submod_quirc-${SUBMOD_quirc_TAG}.tar.gz
		https://github.com/monero-project/monero/archive/${SUBMOD_monero_TAG}.tar.gz -> monero-gui_submod_monero-${SUBMOD_monero_TAG}.tar.gz
		https://github.com/miniupnp/miniupnp/archive/${SUBMOD_monero_SUBMOD_miniupnp_TAG}.tar.gz -> monero-gui_submod_monero_submod_miniupnp_${SUBMOD_monero_SUBMOD_miniupnp_TAG}.tar.gz
		https://github.com/tevador/RandomX/archive/${SUBMOD_monero_SUBMOD_RandomX_TAG}.tar.gz -> monero-gui_submod_monero_submod_RandomX_${SUBMOD_monero_SUBMOD_RandomX_TAG}.tar.gz
		https://github.com/Tencent/rapidjson/archive/${SUBMOD_monero_SUBMOD_rapidjson_TAG}.tar.gz -> monero-gui_submod_monero_submod_rapidjson_${SUBMOD_monero_SUBMOD_rapidjson_TAG}.tar.gz
		https://github.com/monero-project/supercop/archive/${SUBMOD_monero_SUBMOD_supercop_TAG}.tar.gz -> monero-gui_submod_monero_submod_supercop_${SUBMOD_monero_SUBMOD_supercop_TAG}.tar.gz
		https://github.com/trezor/trezor-common/archive/${SUBMOD_monero_SUBMOD_trezor__common_TAG}.tar.gz -> monero-gui_submod_monero_submod_trezor-common_${SUBMOD_monero_SUBMOD_trezor__common_TAG}.tar.gz
		https://github.com/monero-project/unbound/archive/${SUBMOD_monero_SUBMOD_unbound_TAG}.tar.gz -> monero-gui_submod_monero_submod_unbound_${SUBMOD_monero_SUBMOD_unbound_TAG}.tar.gz

	"

declare -A SUBMODS=(
		["0_monero"]="monero"
		["1_quirc"]="external/quirc"
		["2_monero_SUBMOD_miniupnp"]="monero/external/miniupnp"
		["2_monero_SUBMOD_RandomX"]="monero/external/randomx"
		["2_monero_SUBMOD_rapidjson"]="monero/external/rapidjson"
		["2_monero_SUBMOD_supercop"]="monero/external/supercop"
		["2_monero_SUBMOD_trezor__common"]="monero/external/trezor-common"
		["2_monero_SUBMOD_unbound"]="monero/external/unbound"
	)

LICENSE="NEWLIB"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE="hw-wallet qrcode unwind"

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
	"${FILESDIR}/monero-gui-0.17.2.2-linkjobs.patch"
	"${FILESDIR}/monero-gui-0.17.3.0-no-git.patch"
)

CMAKE_MAKEFILE_GENERATOR="emake"
src_prepare() {
	local submod_keys="$( echo "${!SUBMODS[@]}" | tr ' ' $'\n' | sort | tr $'\n' ' ' )"
	for sm in ${submod_keys}; do
		[ -z "$sm" ] && continue
		einfo "Unpacking ${SUBMODS["$sm"]}"
		rmdir "${S}/${SUBMODS["$sm"]}" || die
		smn="${sm#*_}"
		local smt="SUBMOD_${smn}_TAG"
		smn="${smn#*_SUBMOD_}"
		smn="${smn/__/-}"
		mv "${WORKDIR}/${smn}-${!smt}" "${S}/${SUBMODS["$sm"]}" || die
	done

	cmake_src_prepare
}

src_configure () {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DBUILD_GUI_DEPS=ON
		-DMANUAL_SUBMODULES=ON
		# The user can decide for themselves if they want to use ccache.
		-DUSE_CCACHE=OFF
		-DUSE_DEVICE_TREZOR=$(usex hw-wallet)
		-DWITH_SCANNER=$(usex qrcode)
	)
	cmake_src_configure
}

src_compile () {
	cmake_build monero-wallet-gui
}

src_install() {
	debug-print-function ${FUNCNAME} "$@";
	_cmake_check_build_dir;
	pushd "${BUILD_DIR}" > /dev/null || die;

	dobin bin/monero-wallet-gui

	popd > /dev/null || die;
	pushd "${CMAKE_USE_DIR}" > /dev/null || die;
	einstalldocs;
	popd > /dev/null || die;

}
