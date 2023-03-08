# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Minimal Graphical IPV4 Ping Tool by CNLohr"
HOMEPAGE="https://github.com/cntools/cnping"
LICENSE="|| ( BSD MIT )"
SLOT="0"
IUSE=""

CNPING_COMMIT="16ee54ac8a6630a778aa1d1354c4303a70ca56eb"
RAWDRAW_COMMIT="94c5c3bf7d025f08c545f7b289781b2c29d0b3e5"
SRC_URI="https://github.com/cntools/cnping/archive/${CNPING_COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/cntools/rawdraw/archive/${RAWDRAW_COMMIT}.tar.gz -> rawdraw-${RAWDRAW_COMMIT}.tar.gz
"

S="${WORKDIR}/${PN}-${CNPING_COMMIT}"

KEYWORDS="~amd64"

# build libraries and headers
DEPEND="
	x11-libs/libXinerama
"

# runtime
RDEPEND="
	$DEPEND
"

src_prepare() {
	rmdir "${S}/rawdraw" || die
	mv "$WORKDIR/rawdraw-${RAWDRAW_COMMIT}" "${S}/rawdraw" || die

	default_src_prepare
}

src_install() {
	dobin cnping
	doman cnping.1
}
