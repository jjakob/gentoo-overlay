# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Python interface for the SEGGER J-Link"
HOMEPAGE="https://github.com/square/pylink"

SRC_URI="https://github.com/square/pylink/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/pylink-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="
	>=dev-python/psutil-5.2.2[$PYTHON_USEDEP]
	dev-python/six[$PYTHON_USEDEP]
	"
#DEPEND="${RDEPEND}"

# tests broken, don't have time to fix them
RESTRICT="test"
# only unit tests, functional tests require behave and I'm not packaging that!
#distutils_enable_tests unittest

distutils_enable_sphinx docs

python_install_all(){
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}

pkg_postinst(){
	ewarn "This package requires the proprietary SEGGER J-Link library to be installed!"
	ewarn "Please read /usr/share/doc/${P}/README.md.bz2"
}
