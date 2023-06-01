# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11}  )
inherit distutils-r1

DESCRIPTION="Mangling of various binary files (Motorola S-Record, Intel HEX and bin)"
HOMEPAGE="https://github.com/eerimoq/bincopy"

MY_PN="bincopy"
MY_COMMIT="17.14.5"
MY_P="${MY_PN}-${MY_COMMIT}"
SRC_URI="https://github.com/eerimoq/${MY_PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/humanfriendly
	>=dev-python/argparse-addons-0.4
	dev-python/pyelftools
"

distutils_enable_tests unittest
distutils_enable_sphinx docs
