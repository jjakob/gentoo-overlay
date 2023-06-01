# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Dump binary data to hex format and restore from there"
HOMEPAGE="https://pypi.org/project/hexdump/"
SRC_URI="$(pypi_sdist_url "${PN}" "${PV}" .zip)"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

BDEPEND="app-arch/unzip"

distutils_enable_tests unittest

python_test(){
	${EPYTHON} ./hexdump.py --test || die
}

python_install(){
	distutils-r1_python_install

	rm -r "${D}"/usr/data
}
