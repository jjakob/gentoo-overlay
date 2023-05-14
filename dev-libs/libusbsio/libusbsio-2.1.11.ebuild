# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

PYTHON_COMPAT=( python3_{9..11} pypy3 )
inherit python-r1

DESCRIPTION="NXP LIBUSBSIO library"
HOMEPAGE="https://www.nxp.com/design/software/development-software/libusbsio-host-library-for-usb-enabled-mcus:LIBUSBSIO"

SRC_URI="https://www.nxp.com/downloads/en/libraries/${P}-src.zip"
S="${WORKDIR}/${P}-src"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

BDEPEND="
	app-arch/unzip
	python? ( ${PYTHON_DEPS} )
"
RDEPEND="
	virtual/libudev
	python? ( ${PYTHON_DEPS} )
"

DEPEND="
	virtual/libudev
"

src_prepare(){
	rm -r bin python/dist || die
	sed -i -e '/^RELDIR = /c\RELDIR = bin' -e '/^DBGDIR = /c\DBGDIR = bin_debug' makefile || die

	# hack: library defaults to a fixed set of paths to find libusbsio.so,
	# none of which are system library locations. Insane.
	sed -i -e 's#dllpath:str=None#dllpath:str="/usr/lib/libusbsio/libusbsio.so"#' python/libusbsio/libusbsio.py || die

	default
}

src_compile(){
	emake release
}

src_install(){
	insinto /usr/lib/${PN}
	doins bin/libusbsio.a
	exeinto /usr/lib/${PN}
	doexe bin/libusbsio.so

	dodoc INFO.md
	use doc && dodoc -r docs
	use examples && dodoc -r test

	if use python; then
		dodoc python/README.md
		use examples && dodoc -r python/{examples,test}
		python_foreach_impl python_domodule python/libusbsio
	fi
}
