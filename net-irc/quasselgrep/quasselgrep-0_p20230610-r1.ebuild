# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="sqlite?"
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Tool for searching quassel logs from the commandline"
HOMEPAGE="https://github.com/jjakob/quasselgrep"

MY_COMMIT="2e8aa301e3716578b7670ce305a84333dcf37e58"
SRC_URI="https://github.com/jjakob/quasselgrep/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+postgres +sqlite"

RDEPEND="
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	postgres? ( dev-python/psycopg:2[${PYTHON_USEDEP}] )
"

RESTRICT="test"
