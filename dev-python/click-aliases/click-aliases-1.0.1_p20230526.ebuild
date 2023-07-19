# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Add (multiple) aliases to a click_ group or command."
HOMEPAGE="https://github.com/click-contrib/click-aliases"

MY_COMMIT="7fa1e5d98f289871985fa25f6eb174b7ca85496b"
MY_P="${PN}-${MY_COMMIT}"
SRC_URI="https://github.com/click-contrib/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]"
BDEPEND="test? ( ${RDEPEND} )"

distutils_enable_tests pytest

python_prepare_all(){
	# https://github.com/click-contrib/click-aliases/issues/5
	sed -i -e \
		"/def test_invalid(runner):/i@pytest.mark.xfail(reason='Upstream issue #5')" \
		tests/test_{basic,foobar}.py

	distutils-r1_python_prepare_all
}

python_install_all(){
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
