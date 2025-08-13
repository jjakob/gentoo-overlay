# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1

DESCRIPTION="arse your binary structs into dataclasses"
HOMEPAGE="https://github.com/matejcik/construct-classes"
SRC_URI="https://github.com/matejcik/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/construct-2.10[${PYTHON_USEDEP}]
	<dev-python/construct-3
"

RESTRICT="test"

python_prepare_all(){
	sed -i '/^include =/d' pyproject.toml || die
	distutils-r1_python_prepare_all
}
