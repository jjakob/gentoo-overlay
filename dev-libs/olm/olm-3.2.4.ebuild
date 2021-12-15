# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="An implementation of a well known cryptographic ratchet in C++"
HOMEPAGE="https://gitlab.matrix.org/matrix-org/olm/"

if [[ "${PV}" != 9999 ]] ; then
	SRC_URI="https://gitlab.matrix.org/matrix-org/olm/-/archive/${PV}/${P}.tar.gz"
	S="${WORKDIR}/${P}"
	KEYWORDS="~amd64 ~x86 ~arm64 ~ppc64"
else
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.matrix.org/matrix-org/${PN}"
fi

LICENSE="Apache-2.0"
SLOT="0"
