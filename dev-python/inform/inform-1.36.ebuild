# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1

DESCRIPTION="print & logging utilities for communicating with user"

HOMEPAGE="https://inform.readthedocs.io"
SRC_URI="https://github.com/KenKundert/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"
DEPENDENCIES="dev-python/arrow[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="${DEPENDENCIES}"
RDEPEND="${DEPENDENCIES}"
