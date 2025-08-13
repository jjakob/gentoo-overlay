# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_OPT=1
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1

DESCRIPTION="chip support package for Cypress EZ-USB FX2 series microcontrollers"
HOMEPAGE="https://github.com/whitequark/libfx2"
SRC_URI="https://github.com/whitequark/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+python examples"
RESTRICT="test"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

BDEPEND="
	python? (
		${DISTUTILS_DEPS}
		dev-python/setuptools-scm[${PYTHON_USEDEP}]
	)
"
DEPEND="
	dev-embedded/sdcc[mcs51(+)]
	python? (
		${PYTHON_DEPS}
		dev-python/libusb1[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

wrap_python() {
	local phase=$1
	shift

	if use python; then
		pushd software >/dev/null || die
		distutils-r1_${phase} "$@"
		popd >/dev/null || die
	fi
}

src_prepare(){
	default

	wrap_python ${FUNCNAME}
}

src_configure(){
	default

	wrap_python ${FUNCNAME}
}

src_compile(){
	unset CFLAGS
	emake -C firmware || die
	use examples && { emake -C examples || die; }

	wrap_python ${FUNCNAME}
}

src_install() {
	default

	wrap_python ${FUNCNAME}

	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc examples/*/build/*.ihex
	fi
}
