# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit savedconfig xdg

DESCRIPTION='a fast, lightweight, vim-like browser based on webkit'
HOMEPAGE='http://fanglingsu.github.io/vimb/'

MY_COMMIT="6e8267580d7fefd5a091306152fe6c4ef44bb909"
SRC_URI="https://github.com/fanglingsu/vimb/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE='GPL-3'
SLOT='0'
KEYWORDS='~amd64'
IUSE='savedconfig'

RDEPEND='
	gui-libs/gtk:4
	net-libs/webkit-gtk:6
	net-libs/libsoup:3.0
	virtual/libc
	dev-libs/glib:2
'
DEPEND="
	${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default
	restore_config config.def.h

	sed -i -e "/^version = /c\\version = ${PVR}${MY_COMMIT:+"+git${MY_COMMIT:0:8}"}" Makefile
}

src_compile() {
	emake PREFIX="/usr"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
	save_config src/config.def.h
}
