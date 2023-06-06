# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Python library for bitbox02 communication"
HOMEPAGE="https://github.com/digitalbitbox/bitbox02-firmware"
SRC_URI="https://github.com/digitalbitbox/bitbox02-firmware/archive/refs/tags/py-bitbox02-${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/bitbox02-firmware-py-bitbox02-${PV}/py/bitbox02"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# setup.py says hidapi>=0.14.0 but that's only to fix a bug on macOS, Linux doesn't need it
RDEPEND="
	>=dev-python/base58-2[${PYTHON_USEDEP}]
	>=dev-python/ecdsa-0.14[${PYTHON_USEDEP}]
	>=dev-python/hidapi-0.7.99[${PYTHON_USEDEP}]
	>=dev-python/noiseprotocol-0.3[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.20[${PYTHON_USEDEP}]
	>=dev-python/semver-2.8.1[${PYTHON_USEDEP}]
	"
BDEPEND=""

RESTRICT="test"
