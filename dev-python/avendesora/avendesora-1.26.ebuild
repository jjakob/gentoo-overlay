# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1

DESCRIPTION="A password generator and account manager."

HOMEPAGE="https://avendesora.readthedocs.io"
SRC_URI="https://github.com/KenKundert/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="GPL-3+"

SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"
DEPENDENCIES="dev-python/appdirs[${PYTHON_USEDEP}]
	>dev-python/arrow-0.14[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/inform[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	>=dev-python/python-gnupg-0.4.4[${PYTHON_USEDEP}]
	dev-python/pyotp[${PYTHON_USEDEP}]"
BDEPEND="${DEPENDENCIES}"
RDEPEND="${DEPENDENCIES}"
