# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="RLP (Recursive Length Prefix) - Encode and decode data structures"
HOMEPAGE="https://github.com/SamuelHaidu/simple-rlp"

MY_COMMIT="afe3d5a0c19e283e24ac893e3eb1f46892cd188f"
MY_P="${PN}-${MY_COMMIT}"
SRC_URI="https://github.com/SamuelHaidu/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest

python_test(){
	eunittest tests
}
