# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="Open Source Secure Provisioning SDK for NXP MCU/MPU"
HOMEPAGE="https://github.com/nxp-mcuxpresso/spsdk"

MY_PN="spsdk"
MY_COMMIT="1.10.0"
MY_P="${MY_PN}-${MY_COMMIT}"
SRC_URI="https://github.com/nxp-mcuxpresso/spsdk/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64" # x86 is missing from dev-python/click-option-group::guru
IUSE="examples"

RDEPEND="
	>=dev-python/asn1crypto-1.2[$PYTHON_USEDEP]
	<dev-python/asn1crypto-1.6[$PYTHON_USEDEP]
	=dev-python/astunparse-1.6*[$PYTHON_USEDEP]
	>=dev-python/bincopy-17.14.5[$PYTHON_USEDEP]
	=dev-python/bincopy-17.14*[$PYTHON_USEDEP]
	>=dev-python/bitstring-3.1[$PYTHON_USEDEP]
	<dev-python/bitstring-4.1[$PYTHON_USEDEP]
	>=dev-python/click-7.1[$PYTHON_USEDEP]
	<dev-python/click-8.2[$PYTHON_USEDEP]
	>=dev-python/click-option-group-0.3.0[$PYTHON_USEDEP]
	<dev-python/click-option-group-0.6[$PYTHON_USEDEP]
	<dev-python/click-command-tree-1.2[$PYTHON_USEDEP]
	>=dev-python/colorama-0.4.6[$PYTHON_USEDEP]
	=dev-python/colorama-0.4*[$PYTHON_USEDEP]
	=dev-python/commentjson-0.9*[$PYTHON_USEDEP]
	<dev-python/crcmod-1.8[$PYTHON_USEDEP]
	>=dev-python/cryptography-3.4.4[$PYTHON_USEDEP]
	<dev-python/cryptography-40.1[$PYTHON_USEDEP]
	<dev-python/deepmerge-1.2[$PYTHON_USEDEP]
	>=dev-python/fastjsonschema-2.15.1[$PYTHON_USEDEP]
	<dev-python/fastjsonschema-2.17[$PYTHON_USEDEP]
	<dev-python/hexdump-3.4[$PYTHON_USEDEP]
	>=dev-python/jinja-3.0[$PYTHON_USEDEP]
	<dev-python/jinja-3.2[$PYTHON_USEDEP]
	>=dev-libs/libusbsio-2.1.11[python,$PYTHON_USEDEP]
	=dev-libs/libusbsio-2.1*[python,$PYTHON_USEDEP]
	<dev-python/oscrypto-1.4[$PYTHON_USEDEP]
	>=dev-python/pycryptodome-3.9.3[$PYTHON_USEDEP]
	<dev-python/pycryptodome-3.18[$PYTHON_USEDEP]
	>=dev-python/pylink-square-0.8.2[$PYTHON_USEDEP]
	=dev-python/pyocd-0.35*[$PYTHON_USEDEP]
	>=dev-python/pyserial-3.1[$PYTHON_USEDEP]
	<dev-python/pyserial-3.6[$PYTHON_USEDEP]
	=dev-python/ruamel-yaml-0.17*[$PYTHON_USEDEP]
	dev-python/sly-python[$PYTHON_USEDEP]
	<dev-python/typing-extensions-4.6[$PYTHON_USEDEP]
"
BDEPEND="
	test? (
		<dev-python/voluptuous-0.14[$PYTHON_USEDEP]
	)
"

PATCHES="${FILESDIR}"

distutils_enable_tests pytest

# don't have time to figure out all dependencies
# missing: jsonschema2md and more
#distutils_enable_sphinx docs \
#	dev-python/sphinx-rtd-theme \
#	dev-python/sphinx-autodoc-typehints \
#	dev-python/sphinx-click

python_install_all(){
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
