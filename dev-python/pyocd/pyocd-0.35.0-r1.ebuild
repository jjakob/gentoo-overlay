# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="ARM Cortex-M debugger for Python"
HOMEPAGE="https://github.com/pyocd/pyOCD"

SRC_URI="https://github.com/pyocd/pyOCD/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${P^^[ocd]}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="
	=dev-libs/capstone-4*[python]
	>=dev-python/cmsis-pack-manager-0.5.2[$PYTHON_USEDEP]
	=dev-python/cmsis-pack-manager-0*[$PYTHON_USEDEP]
	=dev-python/colorama-0*[$PYTHON_USEDEP]
	>=dev-python/importlib-metadata-3.6[$PYTHON_USEDEP]
	=dev-python/intelhex-2*[$PYTHON_USEDEP]
	>=dev-python/intervaltree-3.0.2[$PYTHON_USEDEP]
	=dev-python/intervaltree-3*[$PYTHON_USEDEP]
	>=dev-python/lark-1.1.5[$PYTHON_USEDEP]
	=dev-python/lark-1*[$PYTHON_USEDEP]
	=dev-python/natsort-8*[$PYTHON_USEDEP]
	>=dev-python/prettytable-2[$PYTHON_USEDEP]
	<dev-python/prettytable-4[$PYTHON_USEDEP]
	=dev-python/pyelftools-0*[$PYTHON_USEDEP]
	=dev-python/pylink-square-1*[$PYTHON_USEDEP]
	>=dev-python/pyusb-1.2.1[$PYTHON_USEDEP]
	=dev-python/pyusb-1*[$PYTHON_USEDEP]
	=dev-python/pyyaml-6*[$PYTHON_USEDEP]
	>=dev-python/six-1.15[$PYTHON_USEDEP]
	=dev-python/six-1*[$PYTHON_USEDEP]
	=dev-python/typing-extensions-4*[$PYTHON_USEDEP]
	"
BDEPEND="
	doc? ( app-doc/doxygen[dot] )
"

PATCHES="${FILESDIR}"

distutils_enable_tests pytest

python_compile_all(){
	if use doc; then
		pushd "${S}/docs" >/dev/null || die
		sed -i -E -e '/^QUIET/c\QUIET = YES' -e 's/(^WARN.*= )YES/\1NO/' Doxyfile || die
		doxygen Doxyfile || die
		popd >/dev/null || die
	fi
}

python_install_all(){
	use doc && dodoc -r docs
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
