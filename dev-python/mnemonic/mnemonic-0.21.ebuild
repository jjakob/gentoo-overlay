# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Ref. implementation of BIP-0039: Mnemonic code for generating deterministic keys"
HOMEPAGE="https://github.com/trezor/python-mnemonic"
MY_PN="python-mnemonic"
SRC_URI="https://github.com/trezor/python-mnemonic/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest

python_test() {
	eunittest -s tests
}
