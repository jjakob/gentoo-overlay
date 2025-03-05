# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Graphical application to manage Nitrokey 3 devices"
HOMEPAGE="
	https://github.com/Nitrokey/nitrokey-app2/
	https://docs.nitrokey.com/software/nk-app2/
"
LICENSE="Apache-2.0"
SLOT="0"

if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/Nitrokey/nitrokey-app2.git"
else
    SRC_URI="https://github.com/Nitrokey/nitrokey-app2/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
    KEYWORDS="~amd64"
fi

RDEPEND="
	>=dev-python/pyside-6.6.0[gui,uitools,widgets,${PYTHON_USEDEP}]
	>=dev-python/nitrokey-sdk-py-0.2.3[${PYTHON_USEDEP}]
	>=dev-python/usb-monitor-1.21[${PYTHON_USEDEP}]
	dev-python/fido2[${PYTHON_USEDEP}]
"
