# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} pypy3 )
inherit distutils-r1

DESCRIPTION="Python module to handle type-length-value (TLV) encoded data"
HOMEPAGE="https://github.com/jlusiardi/tlv8_python"

MY_PN="tlv8_python"
MY_COMMIT="0.10.0"
MY_P="${MY_PN}-${MY_COMMIT}"
SRC_URI="https://github.com/jlusiardi/${MY_PN}/archive/v${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests unittest
