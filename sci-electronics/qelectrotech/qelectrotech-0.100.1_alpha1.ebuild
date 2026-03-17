# Copyright 2001-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="CAD/CAE editor for electrical schematics and diagrams"
HOMEPAGE="https://qelectrotech.org/"

MY_PN="qelectrotech-source-mirror"
MY_COMMIT="5f318e09c8c8be28a008e5f6be087cb9a48a2b8d"
SUBMOD_SingleApplication_TAG="cbe496bc01e6515f9692824bf36d5136e8208c85"
SUBMOD_doxygen__awesome__css_TAG="568f56cde6ac78b6dfcc14acd380b2e745c301ea"
SUBMOD_qelectrotech__elements_TAG="4e7f569dca75ee7ca78fc86b33cd800dfb4951d7"
SRC_URI="https://github.com/qelectrotech/${MY_PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/${SUBMOD_SingleApplication_TAG}.tar.gz -> ${PN}_submod_SingleApplication_${SUBMOD_SingleApplication_TAG}.tar.gz
	https://github.com/jothepro/doxygen-awesome-css/archive/${SUBMOD_doxygen__awesome__css_TAG}.tar.gz -> ${PN}_submod_doxygen__awesome__css_${SUBMOD_doxygen__awesome__css_TAG}.tar.gz
	https://github.com/qelectrotech/qelectrotech-elements/archive/${SUBMOD_qelectrotech__elements_TAG}.tar.gz -> ${PN}_submod_elements_${SUBMOD_qelectrotech__elements_TAG}.tar.gz"
MY_P="${MY_PN}-${MY_COMMIT}"
S="${WORKDIR}/${MY_P}"

declare -A SUBMODS=(
	["0_SingleApplication"]="SingleApplication"
	["0_doxygen__awesome__css"]="doxygen-awesome-css"
	["0_qelectrotech__elements"]="elements"
)

LICENSE="CC-BY-3.0 GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

BDEPEND="
	virtual/pkgconfig
	doc? ( app-text/doxygen )
"

RDEPEND="
	dev-qt/qtbase:6[concurrent,gui,network,sql,sqlite,widgets,xml]
	dev-qt/qtsvg:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/kwidgetsaddons:6
	dev-db/sqlite:3
	>=dev-libs/pugixml-1.15
"
DEPEND="${RDEPEND}"

DOCS=( CREDIT ChangeLog README )

PATCHES=(
	"${FILESDIR}/qelectrotech-0.100.1_alpha1-fix-paths.patch"
	"${FILESDIR}/qelectrotech-0.100.1_alpha1-dont-install-doc-files.patch"
	"${FILESDIR}/qelectrotech-0.100.1_alpha1-system-pugixml.patch"
)

my_prepare_submods(){
	local submod_keys="$( echo "${!SUBMODS[@]}" | tr ' ' $'\n' | sort | tr $'\n' ' ' )"
	for sm in ${submod_keys}; do
		[ -z "$sm" ] && continue
		einfo "Moving submodule ${SUBMODS["$sm"]}"
		rmdir "${S}/${SUBMODS["$sm"]}" || die
		smn="${sm#*_}"
		local smt="SUBMOD_${smn}_TAG"
		smn="${smn#*_SUBMOD_}"
		smn="${smn//__/-}"
		mv "${WORKDIR}/${smn}-${!smt}" "${S}/${SUBMODS["$sm"]}" || die
	done
}

src_prepare() {
	my_prepare_submods

	cmake_src_prepare
	sed -e "/QHG_LOCATION/s:\".*\":""$(qt6_get_bindir)/../libexec/qhelpgenerator"":" -i Doxyfile || die
	# tried this, but qetapp.cpp:213 doesn't read from resources, so install qm files in src_install instead
	#sed -ie '/QET_LANG_PATH/s,".*",":/i18n/",' cmake/paths_compilation_installation.cmake || die
}

src_configure() {
	local mycmakeargs=(
		-DPACKAGE_TESTS=OFF
		-DGIT_COMMIT_SHA=${MY_COMMIT}
		-DFETCHCONTENT_SOURCE_DIR_SINGLEAPPLICATION="${S}/SingleApplication"
		-DBUILD_PUGIXML=NO
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	insinto /usr/share/qelectrotech/lang/
	doins "${BUILD_DIR}"/*.qm

	if use doc; then
		doxygen Doxyfile || die
		local HTML_DOCS=( "doc/html/." )
	fi

	einstalldocs
}
