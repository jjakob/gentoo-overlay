# Copyright 2001-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils desktop xdg-utils

DESCRIPTION="Use your pc sound card as an oscilloscope, function-generator, and UART tester."
HOMEPAGE="https://sourceforge.net/projects/micoscope/"

MY_REV="r${PV#*_p}"
SRC_URI="https://sourceforge.net/code-snapshots/svn/m/mi/micoscope/src/micoscope-src-${MY_REV}.zip -> ${P}.zip"
MY_P="micoscope-src-${MY_REV}"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	app-arch/unzip
"
RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	sci-libs/fftw:3.0=
"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake5 "MicOscope.pro"
}

src_install() {
	newbin "MicOscope" "micoscope"
	doicon -s 48 "res/micoscope.png"
	make_desktop_entry "micoscope" "MicOscope" "micoscope" "Electronics;Science" "StartupWMClass=micoscope"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
