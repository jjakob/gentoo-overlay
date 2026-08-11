# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..15} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="A reference implementation of the SLIP-0010 specification"
HOMEPAGE="https://github.com/trezor/python-slip10"
MY_PN="python-slip10"
SRC_URI="https://github.com/trezor/python-slip10/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/cryptography[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
