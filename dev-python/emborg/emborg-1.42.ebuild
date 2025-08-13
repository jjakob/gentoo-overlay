# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1

DESCRIPTION="Borg front end."

HOMEPAGE="https://emborg.readthedocs.io"
SRC_URI="https://github.com/KenKundert/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="GPL-3+"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"
DEPENDENCIES="dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/arrow[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
	>=dev-python/inform-1.31[${PYTHON_USEDEP}]
	dev-python/nestedtext[${PYTHON_USEDEP}]
	dev-python/quantiphy[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="${DEPENDENCIES}"
RDEPEND="${DEPENDENCIES}"

pkg_postinst(){
	elog "To use Avendesora install 'dev-python/avendesora'"
}
