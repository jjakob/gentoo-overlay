# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit golang-build

DESCRIPTION="A terminal based Matrix client written in Go"
HOMEPAGE="https://github.com/tulir/${PN}"
LICENSE="AGPL-3"
SLOT="0"
IUSE="+encryption"
EGO_PN="github.com/tulir/${PN}"

if [[ "${PV}" == 9999 ]] ; then
	inherit git-r3 golang-vcs
	EGIT_REPO_URI="https://github.com/tulir/${PN}.git"
else
	inherit golang-vcs-snapshot
	SRC_URI="https://github.com/tulir/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
	KEYWORDS="amd64 ~x86 ~arm64 ~ppc64"
fi

DEPEND="encryption? ( >=dev-libs/olm-3 )"
RDEPEND="${DEPEND}"

src_compile() {
	use encryption || export CGO_ENABLED=0
	go build
}

src_install() {
	dobin ${PN}
}
