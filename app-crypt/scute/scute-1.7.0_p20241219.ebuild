# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A PKCS #11 module for OpenPGP smartcards"
HOMEPAGE="http://www.scute.org/"
MY_COMMIT="512ed39637a769ffac574e7d6a3053b1a3898616"
SRC_URI="https://git.gnupg.org/cgi-bin/gitweb.cgi?p=scute.git;a=snapshot;h=${MY_COMMIT};sf=tgz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT:0:7}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

TESTS_DEPEND="
	>=app-crypt/gnupg-2.2[smartcard]
	app-crypt/pinentry"
DEPEND="
	>=dev-libs/libgpg-error-1.38
	>=dev-libs/libassuan-2.5"
RDEPEND="
	${DEPEND}
	test? ( ${TESTS_DEPEND} )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--libdir="${EPREFIX}"/usr/$(get_libdir)/pkcs11 \
		$(use_enable test tests) \
		--enable-maintainer-mode
}

src_install() {
	default

	# only building plugins
	find "${ED}" -name '*.la' -delete || die
}
