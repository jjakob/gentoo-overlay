# Copyright 2001-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

DESCRIPTION="Qt5 application to design electric diagrams"
HOMEPAGE="https://qelectrotech.org/"

MY_PN="qelectrotech-source-mirror"
MY_COMMIT="3d6ab1b0503c23d07a6d5fc423a2b840b1845e9c"
SUBMOD_SingleApplication_TAG="8c48163c4d3fbba603cfe8a5b94046c9dad71825"
SUBMOD_qelectrotech__elements_TAG="c674a866e727bd4d23674d49f642ba65b00e84c3"
SUBMOD_pugixml_TAG="2e357d19a3228c0a301727aac6bea6fecd982d21"
SRC_URI="https://github.com/qelectrotech/${MY_PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/${SUBMOD_SingleApplication_TAG}.tar.gz -> ${PN}_submod_SingleApplication_${SUBMOD_SingleApplication_TAG}.tar.gz
	https://github.com/qelectrotech/qelectrotech-elements/archive/${SUBMOD_qelectrotech__elements_TAG}.tar.gz -> ${PN}_submod_elements_${SUBMOD_qelectrotech__elements_TAG}.tar.gz
	https://github.com/zeux/pugixml/archive/${SUBMOD_pugixml_TAG}.tar.gz -> ${PN}_submod_pugixml_${SUBMOD_pugixml_TAG}.tar.gz"
MY_P="${MY_PN}-${MY_COMMIT}"
S="${WORKDIR}/${MY_P}"

declare -A SUBMODS=(
	["0_SingleApplication"]="SingleApplication"
	["0_qelectrotech__elements"]="elements"
	["0_pugixml"]="pugixml"
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
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kwidgetsaddons:5
"
DEPEND="${RDEPEND}"

DOCS=( CREDIT ChangeLog README )

PATCHES=(
	"${FILESDIR}/${P}-fix-paths.patch"
	"${FILESDIR}/${P}-nomancompress.patch"
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
		smn="${smn/__/-}"
		mv "${WORKDIR}/${smn}-${!smt}" "${S}/${SUBMODS["$sm"]}" || die
	done
}

src_prepare() {
	my_prepare_submods

	sed -ie 's/$(shell git.*)/'"${MY_COMMIT}/" "${PN}.pro" || die
	default
}

src_configure() {
	eqmake5 "${PN}.pro"
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	if use doc; then
		doxygen Doxyfile || die
		local HTML_DOCS=( "doc/html/." )
	fi

	einstalldocs
}
