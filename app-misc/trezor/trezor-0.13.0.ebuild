# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} pypy3 )
inherit distutils-r1 bash-completion-r1

DESCRIPTION="Python library and command-line client for Trezor Hardware Wallet"
HOMEPAGE="https://trezor.io"
SRC_URI="https://github.com/trezor/trezor-firmware/archive/refs/tags/python/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/trezor-firmware-python-v${PV}/python"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="hidapi qt5 extra"

RDEPEND="
	>=dev-python/attrs-19.2.0[${PYTHON_USEDEP}]
	>=dev-python/click-7[${PYTHON_USEDEP}]
	<dev-python/click-9
	>=dev-python/construct-2.9[${PYTHON_USEDEP}]
	>=dev-python/ecdsa-0.9[${PYTHON_USEDEP}]
	>=dev-python/libusb1-1.6.4[${PYTHON_USEDEP}]
	>=dev-python/mnemonic-0.19[${PYTHON_USEDEP}]
	>=dev-python/requests-2.4[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.10[${PYTHON_USEDEP}]
	hidapi? ( >=dev-python/hidapi-0.8[${PYTHON_USEDEP}] )
	qt5? ( dev-python/PyQt5[gui,widgets,${PYTHON_USEDEP}] )
	extra? ( dev-python/pillow[${PYTHON_USEDEP}] )
"
# some dependencies are from guru
# missing packages for ethereum: rlp, web3
# missing packages for stellar: stellar-sdk

distutils_enable_tests pytest

python_prepare_all() {
	cat >> pytest.ini <<-EOF
	[pytest]
	addopts = -rfE --strict-markers
	testpaths = tests
	xfail_strict = true
	junit_family = xunit2
	EOF
	distutils-r1_python_prepare_all
}

python_test() {
	local EPYTEST_IGNORE=( "tests/test_stellar.py" )
	epytest tests
}

python_install_all() {
	distutils-r1_python_install_all

	cp -a bash_completion.d/trezorctl{.sh,}
	dobashcomp bash_completion.d/trezorctl
}
