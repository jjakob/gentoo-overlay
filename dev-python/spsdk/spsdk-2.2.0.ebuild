# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Open Source Secure Provisioning SDK for NXP MCU/MPU"
HOMEPAGE="https://github.com/nxp-mcuxpresso/spsdk"

MY_PN="spsdk"
MY_COMMIT="2.2.0"
MY_P="${MY_PN}-${MY_COMMIT}"
SRC_URI="https://github.com/nxp-mcuxpresso/spsdk/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64" # x86 is missing from dev-python/click-option-group::guru
IUSE="examples"

RDEPEND="
	>=dev-python/asn1crypto-1.2[$PYTHON_USEDEP]
	<dev-python/asn1crypto-1.6[$PYTHON_USEDEP]
	>=dev-python/bincopy-17.14.5[$PYTHON_USEDEP]
	<dev-python/bincopy-21[$PYTHON_USEDEP]
	>=dev-python/bitstring-3.1[$PYTHON_USEDEP]
	<dev-python/bitstring-5[$PYTHON_USEDEP]
	>=dev-python/click-7.1[$PYTHON_USEDEP]
	<dev-python/click-8.2[$PYTHON_USEDEP]
	>=dev-python/click-option-group-0.3.0[$PYTHON_USEDEP]
	<dev-python/click-option-group-0.6[$PYTHON_USEDEP]
	<dev-python/click-command-tree-1.3[$PYTHON_USEDEP]
	>=dev-python/colorama-0.4.6[$PYTHON_USEDEP]
	=dev-python/colorama-0.4*[$PYTHON_USEDEP]
	=dev-python/commentjson-0.9*[$PYTHON_USEDEP]
	<dev-python/crcmod-1.8[$PYTHON_USEDEP]
	>=dev-python/cryptography-3.4.4[$PYTHON_USEDEP]
	<dev-python/cryptography-43[$PYTHON_USEDEP]
	<dev-python/deepmerge-1.2[$PYTHON_USEDEP]
	>=dev-python/fastjsonschema-2.15.1[$PYTHON_USEDEP]
	=dev-python/fastjsonschema-2*[$PYTHON_USEDEP]
	<dev-python/hexdump-3.4[$PYTHON_USEDEP]
	>=dev-libs/libusbsio-2.1.11[python,$PYTHON_USEDEP]
	=dev-libs/libusbsio-2*[python,$PYTHON_USEDEP]
	<dev-python/oscrypto-1.4[$PYTHON_USEDEP]
	=dev-python/platformdirs-4*[$PYTHON_USEDEP]
	=dev-python/prettytable-3*[$PYTHON_USEDEP]
	=dev-python/pyocd-0.36*[$PYTHON_USEDEP]
	>=dev-python/pyserial-3.1[$PYTHON_USEDEP]
	<dev-python/pyserial-3.6[$PYTHON_USEDEP]
	=dev-python/ruamel-yaml-0*[$PYTHON_USEDEP]
	=dev-python/requests-2*[$PYTHON_USEDEP]
	dev-python/sly-python[$PYTHON_USEDEP]
	=dev-python/typing-extensions-4*[$PYTHON_USEDEP]
	dev-python/importlib-metadata[$PYTHON_USEDEP]
"
BDEPEND="
	test? (
		<dev-python/voluptuous-0.15[$PYTHON_USEDEP]
	)
"

#PATCHES="${FILESDIR}/patches_2.1.1"

distutils_enable_tests pytest

# don't have time to figure out all dependencies
# missing: jsonschema2md and more
#distutils_enable_sphinx docs \
#	dev-python/sphinx-rtd-theme \
#	dev-python/sphinx-autodoc-typehints \
#	dev-python/sphinx-click

python_prepare_all(){
#	sed -i -e "/import /iimport pytest" \
#		tests/dk6/test_dk6_tools.py || die
#	sed -i -e \
#		"/def test_cli_listdev():/i@pytest.mark.xfail(reason='Depends on pyftdi')" \
#		tests/dk6/test_dk6_tools.py || die
#	sed -i -e \
#		"/def test_cli_erase():/i@pytest.mark.xfail(reason='Depends on pyftdi')" \
#		tests/dk6/test_dk6_tools.py || die
#	sed -i -e \
#		"/def test_cli_read():/i@pytest.mark.xfail(reason='Depends on pyftdi')" \
#		tests/dk6/test_dk6_tools.py || die
	eqawarn "Deleting tests/mcu_examples/test_jupyter.py"
	rm tests/mcu_examples/test_jupyter.py || die

	distutils-r1_python_prepare_all
}

python_install_all(){
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
