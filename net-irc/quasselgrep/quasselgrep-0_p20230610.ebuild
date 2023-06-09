# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
PYTHON_REQ_USE="sqlite"
inherit distutils-r1

DESCRIPTION="Tool for searching quassel logs from the commandline"
HOMEPAGE="https://github.com/fish-face/quasselgrep"

MY_COMMIT="af23f353a21e0d58b4010d6bec89e51579a9b9b6"
SRC_URI="https://github.com/jjakob/quasselgrep/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="postgres"

RDEPEND="
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	postgres? ( dev-python/psycopg:2[${PYTHON_USEDEP}] )
"

RESTRICT="test"
