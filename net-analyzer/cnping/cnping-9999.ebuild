# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Minimal Graphical IPV4 Ping Tool by CNLohr"
HOMEPAGE="https://github.com/cntools/cnping"
LICENSE="|| ( BSD MIT )"
SLOT="0"
IUSE=""

inherit git-r3
EGIT_REPO_URI="https://github.com/cntools/${PN}.git"
EGIT_BRANCH="master"

if [[ ${PV} == "9999" ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64"
fi

# build libraries and headers
DEPEND="
	x11-libs/libXinerama
"

# runtime
RDEPEND="
	$DEPEND
"

src_install() {
	dobin cnping
	doman cnping.1
}
