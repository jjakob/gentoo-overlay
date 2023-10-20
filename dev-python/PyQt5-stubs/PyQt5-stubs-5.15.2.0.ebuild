EAPI=8
PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Stubs for PyQt5"
HOMEPAGE="
    https://github.com/python-qt-tools/PyQt5-stubs
"
SLOT="0"
LICENSE="BSD"


if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/python-qt-tools/PyQt5-stubs"
else
    inherit pypi
    KEYWORDS="~amd64"
fi

RDEPEND="
"