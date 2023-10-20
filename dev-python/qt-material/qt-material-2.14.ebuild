EAPI=8
PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Material inspired stylesheet for PySide2, PySide6, PyQt5 and PyQt6"
HOMEPAGE="
    https://github.com/UN-GCPDS/qt-material
"
SLOT="0"
LICENSE="BSD"


if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/UN-GCPDS/qt-material"
else
    inherit pypi
    KEYWORDS="~amd64"
fi

RDEPEND="
    dev-python/jinja
"