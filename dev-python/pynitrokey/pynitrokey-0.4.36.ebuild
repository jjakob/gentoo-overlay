# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1 udev

DESCRIPTION="A command line interface for the Nitrokey FIDO2, Start, 3 and NetHSM"
HOMEPAGE="https://github.com/Nitrokey/pynitrokey"

libnitrokey_commit=b34a473ae3b63adb229760d216a7d8ae7a40cbe9
SRC_URI="https://github.com/Nitrokey/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
		https://github.com/Nitrokey/libnitrokey/archive/${libnitrokey_commit}.tar.gz
			-> libnitrokey-${libnitrokey_commit}.gh.tar.gz
"
S_libnitrokey="${WORKDIR}/libnitrokey-${libnitrokey_commit}"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="~amd64" # x86 missing in frozendict, spsdk
IUSE="udev"

RDEPEND="
	>=dev-python/certifi-14.5.15[${PYTHON_USEDEP}]
	dev-python/cffi[${PYTHON_USEDEP}]
	=dev-python/click-8*[${PYTHON_USEDEP}]
	>=dev-python/cryptography-39[${PYTHON_USEDEP}]
	dev-python/ecdsa[${PYTHON_USEDEP}]
	=dev-python/frozendict-2.3*[${PYTHON_USEDEP}]
	=dev-python/fido2-1*[${PYTHON_USEDEP}]
	dev-python/intelhex[${PYTHON_USEDEP}]
	dev-python/nkdfu[${PYTHON_USEDEP}]
	=dev-python/python-dateutil-2*[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	=dev-python/spsdk-1.10*[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	=dev-python/urllib3-1*[${PYTHON_USEDEP}]
	dev-python/tlv8[${PYTHON_USEDEP}]
	=dev-python/typing-extensions-4*[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.17.3[${PYTHON_USEDEP}]
"

# tests require a connected nitrokey device and will destroy the data on it!
# it would be bad if the user was not expecting this.
RESTRICT="test"
#distutils_enable_tests pytest

python_install_all() {
	use udev && udev_dorules "${S_libnitrokey}/data/41-nitrokey.rules"

	distutils-r1_python_install_all
}

pkg_postinst(){
	use udev && udev_reload
}

pkg_postrm(){
	use udev && udev_reload
}
