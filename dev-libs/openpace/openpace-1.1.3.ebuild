# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_OPT=1
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
inherit autotools distutils-r1

DESCRIPTION="Cryptographic library for EAC version 2"
HOMEPAGE="https://frankmorgner.github.io/openpace"
SRC_URI="https://github.com/frankmorgner/openpace/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/4"
KEYWORDS="~amd64"

# language bindings have not been tested yet
IUSE="go java python ruby"

BDEPEND="
	dev-util/gengetopt
	sys-apps/help2man
	python? (
		${DISTUTILS_DEPS}
		dev-lang/swig
	)
"
#	go? (
#		dev-lang/swig
#		dev-lang/go
#		sys-devel/gcc[go] )
#	java? (
#		dev-lang/swig
#		>=virtual/jdk-1.8:* )
#	ruby? (
#		dev-lang/swig
#		dev-lang/ruby )

#libs
DEPEND="
	>=dev-libs/openssl-1.0.2
	python? ( ${PYTHON_DEPS} )
"

RDEPEND="${DEPEND}"
#	java? ( >=virtual/jre-1.8:* )

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

wrap_python() {
	local phase=$1
	shift

	if use python; then
		pushd bindings/python >/dev/null || die
		distutils-r1_${phase} "$@"
		popd >/dev/null || die
	fi
}

src_prepare() {
	default
	eautoreconf

	wrap_python ${FUNCNAME}
}

src_configure() {
	econf \
		--disable-openssl-install \
		$(use_enable go) \
		$(use_enable java) \
		$(use_enable python) \
		$(use_enable ruby) || die

	wrap_python ${FUNCNAME}
}

src_compile() {
	# not running just 1 job causes a race condition that causes a linking error
	emake -j1 || die

	wrap_python ${FUNCNAME}
}

src_test() {
	default

	wrap_python ${FUNCNAME}
}

src_install() {
	default

	wrap_python ${FUNCNAME}

	find "${ED}" -type f -name '*.la' -delete || die
}
