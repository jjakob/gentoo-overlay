# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1

DESCRIPTION="Nitrokey Python SDK"
HOMEPAGE="https://github.com/Nitrokey/nitrokey-sdk-py"

SRC_URI="https://github.com/Nitrokey/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/cryptography-41[${PYTHON_USEDEP}]
	>=dev-python/crcmod-1.7[${PYTHON_USEDEP}]
	<dev-python/crcmod-2[${PYTHON_USEDEP}]
	>=dev-python/fido2-1.1.2[${PYTHON_USEDEP}]
	<dev-python/fido2-2[${PYTHON_USEDEP}]
	>=dev-python/hidapi-0.14[${PYTHON_USEDEP}]
	<dev-python/hidapi-1[${PYTHON_USEDEP}]
	=dev-python/requests-2*[${PYTHON_USEDEP}]
	>=dev-python/tlv8-0.10[${PYTHON_USEDEP}]
	<dev-python/tlv8-1[${PYTHON_USEDEP}]
	>=dev-python/pyserial-3.5[${PYTHON_USEDEP}]
	<dev-python/pyserial-4[${PYTHON_USEDEP}]
	>=dev-python/protobuf-5.26[${PYTHON_USEDEP}]
	<dev-python/protobuf-6[${PYTHON_USEDEP}]
	>=dev-python/semver-3[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs
distutils_enable_tests unittest
