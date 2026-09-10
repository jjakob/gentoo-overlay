# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..15} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="SLIP-39 Shamir Mnemonics"
HOMEPAGE="https://github.com/trezor/python-shamir-mnemonic"
MY_PN="python-shamir-mnemonic"
SRC_URI="https://github.com/trezor/python-shamir-mnemonic/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cli"

RDEPEND="
	cli? ( =dev-python/click-8*[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

src_prepare() {
    sed -i -e '/from bip32utils/d' test_shamir.py || die
    distutils-r1_src_prepare
}

python_test() {
    local EPYTEST_DESELECT=(
		# requires bip32utils which has been deleted and is supposedly incompatible with openssl-3
		'test_shamir.py::test_vectors'
    )
    epytest
}
