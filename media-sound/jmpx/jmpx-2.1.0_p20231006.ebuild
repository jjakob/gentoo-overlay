# Copyright 2001-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils desktop xdg-utils

DESCRIPTION="FM Stereo encoder with RDS support"
HOMEPAGE="https://github.com/jontio/JMPX"

MY_COMMIT="c8a3c5f1fd04577a9b7ce3fb0bf675831f86af96"
SRC_URI="https://github.com/jontio/JMPX/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
MY_P="JMPX-${MY_COMMIT}"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
	media-libs/opus
	virtual/jack
"

DEPEND="${RDEPEND}"

src_prepare(){
	sed -i 's,CONFIG += print_user_info_msgs,,' common.pri || die
	sed -i "s,\(target\.path\) = .*,\1 = /usr/$(get_libdir)," libJMPX/libJMPX.pro || die
	default
}

src_configure() {
	eqmake5 "JMPX.pro"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	newicon "JMPX/myappico.ico" JMPX.ico
	make_desktop_entry "JMPX" "JMPX" "JMPX" "Electronics;Science" "StartupWMClass=JMPX"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
