# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..15} )
inherit distutils-r1 shell-completion

DESCRIPTION="Python library and command-line client for Trezor Hardware Wallet"
HOMEPAGE="https://trezor.io"
SRC_URI="https://github.com/trezor/trezor-firmware/archive/refs/tags/python/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/trezor-firmware-python-v${PV}/python"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="hidapi qt5 extra"

RDEPEND="
	=dev-python/click-8*[${PYTHON_USEDEP}]
	>=dev-python/construct-2.9[${PYTHON_USEDEP}]
	>=dev-python/construct-classes-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/cryptography-47[${PYTHON_USEDEP}]
	>=dev-python/keyring-25.7[${PYTHON_USEDEP}]
	>=dev-python/libusb1-1.6.4[${PYTHON_USEDEP}]
	>=dev-python/mnemonic-0.20[${PYTHON_USEDEP}]
	=dev-python/noiseprotocol-0.3*[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.4[${PYTHON_USEDEP}]
	>=dev-python/requests-2.4[${PYTHON_USEDEP}]
	>=dev-python/shamir-mnemonic-0.3[${PYTHON_USEDEP}]
	>=dev-python/slip10-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.7.1[${PYTHON_USEDEP}]
	hidapi? ( >=dev-python/hidapi-0.8[${PYTHON_USEDEP}] )
	qt5? ( dev-python/PyQt5[gui,widgets,${PYTHON_USEDEP}] )
	extra? ( dev-python/pillow[${PYTHON_USEDEP}] )
"
# missing packages for ethereum: web3
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

	sed -i -e \
		"/def test_/i@pytest.mark.xfail(reason='Requires internet access to download firmware from https://data.trezor.io')" \
		tests/test_firmware.py || die

	distutils-r1_python_prepare_all
}

src_install() {
	distutils-r1_src_install

	cp -a bash_completion.d/trezorctl{.sh,}
	dobashcomp bash_completion.d/trezorctl
}
