# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_AUTOCONF=2.5
inherit autotools

DESCRIPTION="Cryptographic library for EAC version 2"
HOMEPAGE="https://frankmorgner.github.io/openpace"
SRC_URI="https://github.com/frankmorgner/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# language bindings have not been tested yet
IUSE="go java python ruby"

BDEPEND="
	dev-util/gengetopt
	sys-apps/help2man
	go? (
		dev-lang/swig
		dev-lang/go
		sys-devel/gcc[go] )
	java? (
		dev-lang/swig
		>=virtual/jdk-1.8:* )
	python? (
		dev-lang/swig
		dev-lang/python )
	ruby? (
		dev-lang/swig
		dev-lang/ruby )
"

#libs
DEPEND="
	>=dev-libs/openssl-1.0.2
"

RDEPEND="${DEPEND}
	java? ( >=virtual/jre-1.8:* )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable go) $(use_enable java) $(use_enable python) $(use_enable ruby) || die
}

src_compile() {
	# not running just 1 job causes a race condition that causes a linking error
	emake -j1 || die
}

src_install() {
	default

	find "${ED}" -type f -name '*.la' -delete || die
}
