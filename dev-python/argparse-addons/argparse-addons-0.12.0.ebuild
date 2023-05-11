# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="Additional Python argparse types and actions"
HOMEPAGE="https://github.com/eerimoq/argparse_addons"

MY_PN="argparse_addons"
MY_COMMIT="0.12.0"
MY_P="${MY_PN}-${MY_COMMIT}"
SRC_URI="https://github.com/eerimoq/${MY_PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

distutils_enable_tests unittest

python_install_all() {
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
