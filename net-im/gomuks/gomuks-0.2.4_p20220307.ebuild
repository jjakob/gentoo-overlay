# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A terminal based Matrix client written in Go"
HOMEPAGE="https://github.com/tulir/gomuks"
LICENSE="AGPL-3 Apache-2.0 BSD BSD-2 MIT MPL-2.0"
SLOT="0"
IUSE="+encryption"
EGO_PN="github.com/tulir/gomuks"

inherit go-module
EGO_SUM=(
	"github.com/3nprob/cbind v0.0.0-20211207125121-3a585abdeddb"
	"github.com/3nprob/cbind v0.0.0-20211207125121-3a585abdeddb/go.mod"
	"github.com/alecthomas/chroma v0.10.0"
	"github.com/alecthomas/chroma v0.10.0/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/disintegration/imaging v1.6.2"
	"github.com/disintegration/imaging v1.6.2/go.mod"
	"github.com/dlclark/regexp2 v1.4.0"
	"github.com/dlclark/regexp2 v1.4.0/go.mod"
	"github.com/gabriel-vasile/mimetype v1.4.0"
	"github.com/gabriel-vasile/mimetype v1.4.0/go.mod"
	"github.com/gdamore/encoding v1.0.0"
	"github.com/gdamore/encoding v1.0.0/go.mod"
	"github.com/gorilla/mux v1.8.0"
	"github.com/gorilla/mux v1.8.0/go.mod"
	"github.com/gorilla/websocket v1.4.2"
	"github.com/gorilla/websocket v1.4.2/go.mod"
	"github.com/kyokomi/emoji/v2 v2.2.9"
	"github.com/kyokomi/emoji/v2 v2.2.9/go.mod"
	"github.com/lithammer/fuzzysearch v1.1.3"
	"github.com/lithammer/fuzzysearch v1.1.3/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.0.3/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.2.0"
	"github.com/lucasb-eyer/go-colorful v1.2.0/go.mod"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/mattn/go-runewidth v0.0.13"
	"github.com/mattn/go-runewidth v0.0.13/go.mod"
	"github.com/mattn/go-sqlite3 v1.14.11/go.mod"
	"github.com/mattn/go-sqlite3 v1.14.12"
	"github.com/mattn/go-sqlite3 v1.14.12/go.mod"
	"github.com/nu7hatch/gouuid v0.0.0-20131221200532-179d4d0c4d8d"
	"github.com/nu7hatch/gouuid v0.0.0-20131221200532-179d4d0c4d8d/go.mod"
	"github.com/petermattis/goid v0.0.0-20180202154549-b0b1615b78e5"
	"github.com/petermattis/goid v0.0.0-20180202154549-b0b1615b78e5/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/uniseg v0.2.0"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/sasha-s/go-deadlock v0.3.1"
	"github.com/sasha-s/go-deadlock v0.3.1/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/tidwall/gjson v1.12.1/go.mod"
	"github.com/tidwall/gjson v1.14.0"
	"github.com/tidwall/gjson v1.14.0/go.mod"
	"github.com/tidwall/match v1.1.1"
	"github.com/tidwall/match v1.1.1/go.mod"
	"github.com/tidwall/pretty v1.2.0"
	"github.com/tidwall/pretty v1.2.0/go.mod"
	"github.com/tidwall/sjson v1.2.4"
	"github.com/tidwall/sjson v1.2.4/go.mod"
	"github.com/zyedidia/clipboard v0.0.0-20200421031010-7c45b8673834/go.mod"
	"github.com/zyedidia/clipboard v1.0.3"
	"github.com/zyedidia/clipboard v1.0.3/go.mod"
	"github.com/zyedidia/poller v1.0.1"
	"github.com/zyedidia/poller v1.0.1/go.mod"
	"go.etcd.io/bbolt v1.3.6"
	"go.etcd.io/bbolt v1.3.6/go.mod"
	"golang.org/x/crypto v0.0.0-20220213190939-1e6e3497d506"
	"golang.org/x/crypto v0.0.0-20220213190939-1e6e3497d506/go.mod"
	"golang.org/x/image v0.0.0-20191009234506-e7c1f5e7dbb8/go.mod"
	"golang.org/x/image v0.0.0-20220302094943-723b81ca9867"
	"golang.org/x/image v0.0.0-20220302094943-723b81ca9867/go.mod"
	"golang.org/x/net v0.0.0-20210505024714-0287a6fb4125/go.mod"
	"golang.org/x/net v0.0.0-20211112202133-69e39bad7dc2/go.mod"
	"golang.org/x/net v0.0.0-20220127200216-cd36cc0744dd/go.mod"
	"golang.org/x/net v0.0.0-20220225172249-27dd8689420f"
	"golang.org/x/net v0.0.0-20220225172249-27dd8689420f/go.mod"
	"golang.org/x/sys v0.0.0-20200501145240-bc7a7d42d5c3/go.mod"
	"golang.org/x/sys v0.0.0-20200923182605-d9f96fdee20d/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210309040221-94ec62e08169/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20211216021012-1d35b9e2eb4e"
	"golang.org/x/sys v0.0.0-20211216021012-1d35b9e2eb4e/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210220032956-6a3ed077a48d/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/text v0.3.5/go.mod"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/text v0.3.7"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/toast.v1 v1.0.0-20180812000517-0a84660828b2"
	"gopkg.in/toast.v1 v1.0.0-20180812000517-0a84660828b2/go.mod"
	"gopkg.in/vansante/go-ffprobe.v2 v2.0.3"
	"gopkg.in/vansante/go-ffprobe.v2 v2.0.3/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"maunium.net/go/maulogger/v2 v2.3.2"
	"maunium.net/go/maulogger/v2 v2.3.2/go.mod"
	"maunium.net/go/mautrix v0.10.12-0.20220304130457-bca341a29b65"
	"maunium.net/go/mautrix v0.10.12-0.20220304130457-bca341a29b65/go.mod"
	"maunium.net/go/mauview v0.1.4-0.20211207121125-01ffaf935896"
	"maunium.net/go/mauview v0.1.4-0.20211207121125-01ffaf935896/go.mod"
	"maunium.net/go/tcell v0.2.0"
	"maunium.net/go/tcell v0.2.0/go.mod"
)

go-module_set_globals

EGIT_COMMIT="2a07ff67816c035ffb35176ecb19be771abd6e39"
SRC_URI="https://github.com/tulir/gomuks/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
		${EGO_SUM_SRC_URI}"
S=${WORKDIR}/${PN}-${EGIT_COMMIT}
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

DEPEND="encryption? ( >=dev-libs/olm-3 )"
RDEPEND="${DEPEND}"

src_compile() {
	use encryption || export CGO_ENABLED=0
	go build
}

src_install() {
	dobin ${PN}
}

pkg_postinst() {
	has_version -r "x11-misc/xdg-utils" || ewarn "To open media, xdg-open from x11-misc/xdg-utils is required."
	if ! has_version -r "media-video/ffmpeg" ; then
		ewarn "To include audio/video file metadata to uploaded files,"
		ewarn "ffprobe from media-video/ffmpeg is required."
	fi
}
