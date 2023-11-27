# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="A command line interface for the Nitrokey FIDO2, Start, 3 and NetHSM"
HOMEPAGE="https://github.com/Nitrokey/pynitrokey"

SRC_URI="https://github.com/Nitrokey/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="~amd64" # x86 missing in spsdk

RDEPEND="
	>=dev-python/certifi-14.5.15[${PYTHON_USEDEP}]
	dev-python/cffi[${PYTHON_USEDEP}]
	=dev-python/click-8*[${PYTHON_USEDEP}]
	>=dev-python/cryptography-41.0.4[${PYTHON_USEDEP}]
	dev-python/ecdsa[${PYTHON_USEDEP}]
	=dev-python/fido2-1*[${PYTHON_USEDEP}]
	dev-python/intelhex[${PYTHON_USEDEP}]
	dev-python/nkdfu[${PYTHON_USEDEP}]
	=dev-python/python-dateutil-2*[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/spsdk-1.11.0[${PYTHON_USEDEP}]
	=dev-python/spsdk-1.11*[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/tlv8[${PYTHON_USEDEP}]
	=dev-python/typing-extensions-4*[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.17.3[${PYTHON_USEDEP}]
	app-crypt/libnitrokey
	dev-python/click-aliases[${PYTHON_USEDEP}]
	dev-python/semver[${PYTHON_USEDEP}]
	=dev-python/nethsm-0.5*[${PYTHON_USEDEP}]
"

# tests require a connected nitrokey device and will destroy the data on it!
# it would be bad if the user was not expecting this.
RESTRICT="test"
