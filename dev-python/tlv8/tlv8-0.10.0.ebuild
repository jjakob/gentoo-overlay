# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1

DESCRIPTION="Python module to handle type-length-value (TLV) encoded data"
HOMEPAGE="https://github.com/jlusiardi/tlv8_python"

MY_PN="tlv8_python"
SRC_URI="https://github.com/jlusiardi/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest
