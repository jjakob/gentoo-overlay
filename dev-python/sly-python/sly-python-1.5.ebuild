# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Sly Lex Yacc - Python implementation of lex and yacc"
HOMEPAGE="https://github.com/dabeaz/sly"

MY_PN="sly"
MY_COMMIT="1.5"
MY_P="${MY_PN}-${MY_COMMIT}"
SRC_URI="https://github.com/dabeaz/${MY_PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

distutils_enable_tests pytest
distutils_enable_sphinx docs

python_install_all(){
	use examples && dodoc -r example

	distutils-r1_python_install_all
}
