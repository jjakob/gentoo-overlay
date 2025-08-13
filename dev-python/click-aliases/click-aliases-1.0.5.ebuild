# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1

DESCRIPTION="Add (multiple) aliases to a click_ group or command."
HOMEPAGE="https://github.com/click-contrib/click-aliases"

SRC_URI="https://github.com/click-contrib/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]"
BDEPEND="test? ( ${RDEPEND} )"

distutils_enable_tests pytest

#python_prepare_all(){
#	# https://github.com/click-contrib/click-aliases/issues/5
#	sed -i -e \
#		"/def test_invalid(runner):/i@pytest.mark.xfail(reason='Upstream issue #5')" \
#		tests/test_{basic,foobar}.py
#
#	distutils-r1_python_prepare_all
#}

python_install_all(){
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
