# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="Create VCard, QR code, printable business cards with OpenPGP key and fingerprint"
HOMEPAGE="https://github.com/juga0/opgpcard"
SRC_URI="https://github.com/juga0/opgpcard/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples"

RDEPEND="
	>=dev-python/qrcode-5.3[$PYTHON_USEDEP]
	>=dev-python/lxml-4.1[$PYTHON_USEDEP]
	app-crypt/gpgme[python,$PYTHON_USEDEP]
"
BDEPEND+=" doc? ( dev-python/sphinx )"

distutils_enable_tests pytest

python_compile_all() {
	if use doc; then
		pushd docs >/dev/null || die
		for format in html man text; do
			sphinx-build -b "$format" -d _build/doctrees source _build/"$format" || die
		done
		popd >/dev/null || die
		HTML_DOCS+=( "docs/_build/html/." )
	fi
}

python_install_all(){
	if use doc; then
		doman docs/_build/man/opgpcard.1
		dodoc -r docs/_build/text
	else
		doman "$FILESDIR"/opgpcard.1
	fi

	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
