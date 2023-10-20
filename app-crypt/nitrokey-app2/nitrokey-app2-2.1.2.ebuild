# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="This application allows to manage Nitrokey 3 devices"
HOMEPAGE="
    https://github.com/Nitrokey/nitrokey-app2/
"
SLOT="0"
LICENSE="Apache-2.0"

if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/Nitrokey/nitrokey-app2.git"
else
    SRC_URI="https://github.com/Nitrokey/nitrokey-app2/archive/refs/tags/v${PV}.tar.gz"
    KEYWORDS="~amd64"
fi

RDEPEND="
    dev-python/PyQt5
    dev-python/PyQt5-stubs
    dev-python/pyudev
    ~app-crypt/pynitrokey-0.4.38
    dev-python/qt-material
"

src_compile() {
    make build-ui
    distutils-r1_src_compile
}