# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A terminal based Matrix client written in Go"
HOMEPAGE="https://github.com/tulir/gomuks"
LICENSE="AGPL-3 Apache-2.0 BSD BSD-2 MIT MPL-2.0"
SLOT="0"
IUSE="+encryption"
EGO_PN="github.com/tulir/gomuks"

inherit go-module
EGO_SUM=(
	"github.com/aead/siphash v1.0.1/go.mod "
	"github.com/alecthomas/assert v0.0.0-20170929043011-405dbfeb8e38 "
	"github.com/alecthomas/assert v0.0.0-20170929043011-405dbfeb8e38/go.mod "
	"github.com/alecthomas/chroma v0.8.2 "
	"github.com/alecthomas/chroma v0.8.2/go.mod "
	"github.com/alecthomas/colour v0.0.0-20160524082231-60882d9e2721 "
	"github.com/alecthomas/colour v0.0.0-20160524082231-60882d9e2721/go.mod "
	"github.com/alecthomas/kong v0.2.4/go.mod "
	"github.com/alecthomas/repr v0.0.0-20180818092828-117648cd9897 "
	"github.com/alecthomas/repr v0.0.0-20180818092828-117648cd9897/go.mod "
	"github.com/btcsuite/btcd v0.20.1-beta/go.mod "
	"github.com/btcsuite/btclog v0.0.0-20170628155309-84c8d2346e9f/go.mod "
	"github.com/btcsuite/btcutil v0.0.0-20190425235716-9e5f4b9a998d/go.mod "
	"github.com/btcsuite/btcutil v1.0.2 "
	"github.com/btcsuite/btcutil v1.0.2/go.mod "
	"github.com/btcsuite/go-socks v0.0.0-20170105172521-4720035b7bfd/go.mod "
	"github.com/btcsuite/goleveldb v0.0.0-20160330041536-7834afc9e8cd/go.mod "
	"github.com/btcsuite/snappy-go v0.0.0-20151229074030-0bdef8d06723/go.mod "
	"github.com/btcsuite/websocket v0.0.0-20150119174127-31079b680792/go.mod "
	"github.com/btcsuite/winsvc v1.0.0/go.mod "
	"github.com/danwakefield/fnmatch v0.0.0-20160403171240-cbb64ac3d964 "
	"github.com/danwakefield/fnmatch v0.0.0-20160403171240-cbb64ac3d964/go.mod "
	"github.com/davecgh/go-spew v0.0.0-20171005155431-ecdeabc65495/go.mod "
	"github.com/davecgh/go-spew v1.1.0/go.mod "
	"github.com/davecgh/go-spew v1.1.1 "
	"github.com/davecgh/go-spew v1.1.1/go.mod "
	"github.com/disintegration/imaging v1.6.2 "
	"github.com/disintegration/imaging v1.6.2/go.mod "
	"github.com/dlclark/regexp2 v1.2.0 "
	"github.com/dlclark/regexp2 v1.2.0/go.mod "
	"github.com/fsnotify/fsnotify v1.4.7/go.mod "
	"github.com/gabriel-vasile/mimetype v1.2.0 "
	"github.com/gabriel-vasile/mimetype v1.2.0/go.mod "
	"github.com/gdamore/encoding v1.0.0 "
	"github.com/gdamore/encoding v1.0.0/go.mod "
	"github.com/golang/protobuf v1.2.0/go.mod "
	"github.com/gorilla/mux v1.8.0 "
	"github.com/gorilla/mux v1.8.0/go.mod "
	"github.com/gorilla/websocket v1.4.2 "
	"github.com/gorilla/websocket v1.4.2/go.mod "
	"github.com/hpcloud/tail v1.0.0/go.mod "
	"github.com/jessevdk/go-flags v0.0.0-20141203071132-1679536dcc89/go.mod "
	"github.com/jrick/logrotate v1.0.0/go.mod "
	"github.com/kkdai/bstream v0.0.0-20161212061736-f391b8402d23/go.mod "
	"github.com/kyokomi/emoji/v2 v2.2.8 "
	"github.com/kyokomi/emoji/v2 v2.2.8/go.mod "
	"github.com/lib/pq v1.9.0 "
	"github.com/lib/pq v1.9.0/go.mod "
	"github.com/lithammer/fuzzysearch v1.1.1 "
	"github.com/lithammer/fuzzysearch v1.1.1/go.mod "
	"github.com/lucasb-eyer/go-colorful v1.0.3/go.mod "
	"github.com/lucasb-eyer/go-colorful v1.2.0 "
	"github.com/lucasb-eyer/go-colorful v1.2.0/go.mod "
	"github.com/mattn/go-colorable v0.1.6/go.mod "
	"github.com/mattn/go-isatty v0.0.12 "
	"github.com/mattn/go-isatty v0.0.12/go.mod "
	"github.com/mattn/go-runewidth v0.0.9 "
	"github.com/mattn/go-runewidth v0.0.9/go.mod "
	"github.com/mattn/go-sqlite3 v1.14.6 "
	"github.com/mattn/go-sqlite3 v1.14.6/go.mod "
	"github.com/nu7hatch/gouuid v0.0.0-20131221200532-179d4d0c4d8d "
	"github.com/nu7hatch/gouuid v0.0.0-20131221200532-179d4d0c4d8d/go.mod "
	"github.com/onsi/ginkgo v1.6.0/go.mod "
	"github.com/onsi/ginkgo v1.7.0/go.mod "
	"github.com/onsi/gomega v1.4.3/go.mod "
	"github.com/petermattis/goid v0.0.0-20180202154549-b0b1615b78e5 "
	"github.com/petermattis/goid v0.0.0-20180202154549-b0b1615b78e5/go.mod "
	"github.com/pkg/errors v0.8.1/go.mod "
	"github.com/pkg/errors v0.9.1/go.mod "
	"github.com/pmezard/go-difflib v1.0.0 "
	"github.com/pmezard/go-difflib v1.0.0/go.mod "
	"github.com/rivo/uniseg v0.1.0/go.mod "
	"github.com/rivo/uniseg v0.2.0 "
	"github.com/rivo/uniseg v0.2.0/go.mod "
	"github.com/russross/blackfriday/v2 v2.1.0 "
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod "
	"github.com/sasha-s/go-deadlock v0.2.0 "
	"github.com/sasha-s/go-deadlock v0.2.0/go.mod "
	"github.com/sergi/go-diff v1.0.0 "
	"github.com/sergi/go-diff v1.0.0/go.mod "
	"github.com/stretchr/objx v0.1.0/go.mod "
	"github.com/stretchr/testify v1.2.2/go.mod "
	"github.com/stretchr/testify v1.3.0/go.mod "
	"github.com/stretchr/testify v1.6.1 "
	"github.com/stretchr/testify v1.6.1/go.mod "
	"github.com/tidwall/gjson v1.6.8 "
	"github.com/tidwall/gjson v1.6.8/go.mod "
	"github.com/tidwall/match v1.0.3 "
	"github.com/tidwall/match v1.0.3/go.mod "
	"github.com/tidwall/pretty v1.0.2 "
	"github.com/tidwall/pretty v1.0.2/go.mod "
	"github.com/tidwall/sjson v1.1.5 "
	"github.com/tidwall/sjson v1.1.5/go.mod "
	"github.com/zyedidia/clipboard v0.0.0-20200421031010-7c45b8673834/go.mod "
	"github.com/zyedidia/clipboard v1.0.3 "
	"github.com/zyedidia/clipboard v1.0.3/go.mod "
	"github.com/zyedidia/poller v1.0.1 "
	"github.com/zyedidia/poller v1.0.1/go.mod "
	"go.etcd.io/bbolt v1.3.5 "
	"go.etcd.io/bbolt v1.3.5/go.mod "
	"golang.org/x/crypto v0.0.0-20170930174604-9419663f5a44/go.mod "
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod "
	"golang.org/x/crypto v0.0.0-20200115085410-6d4e4cb37c7d/go.mod "
	"golang.org/x/crypto v0.0.0-20210220033148-5ea612d1eb83 "
	"golang.org/x/crypto v0.0.0-20210220033148-5ea612d1eb83/go.mod "
	"golang.org/x/image v0.0.0-20191009234506-e7c1f5e7dbb8/go.mod "
	"golang.org/x/image v0.0.0-20210220032944-ac19c3e999fb "
	"golang.org/x/image v0.0.0-20210220032944-ac19c3e999fb/go.mod "
	"golang.org/x/net v0.0.0-20180906233101-161cd47e91fd/go.mod "
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod "
	"golang.org/x/net v0.0.0-20210220033124-5f55cee0dc0d/go.mod "
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110 "
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod "
	"golang.org/x/sync v0.0.0-20180314180146-1d60e4601c6f/go.mod "
	"golang.org/x/sys v0.0.0-20180909124046-d0be0721c37e/go.mod "
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod "
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod "
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod "
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod "
	"golang.org/x/sys v0.0.0-20200202164722-d101bd2416d5/go.mod "
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod "
	"golang.org/x/sys v0.0.0-20200413165638-669c56c373c4/go.mod "
	"golang.org/x/sys v0.0.0-20200501145240-bc7a7d42d5c3/go.mod "
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68 "
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod "
	"golang.org/x/term v0.0.0-20201117132131-f5c789dd3221/go.mod "
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod "
	"golang.org/x/text v0.3.0/go.mod "
	"golang.org/x/text v0.3.2/go.mod "
	"golang.org/x/text v0.3.3 "
	"golang.org/x/text v0.3.3/go.mod "
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod "
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405 "
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod "
	"gopkg.in/fsnotify.v1 v1.4.7/go.mod "
	"gopkg.in/toast.v1 v1.0.0-20180812000517-0a84660828b2 "
	"gopkg.in/toast.v1 v1.0.0-20180812000517-0a84660828b2/go.mod "
	"gopkg.in/tomb.v1 v1.0.0-20141024135613-dd632973f1e7/go.mod "
	"gopkg.in/vansante/go-ffprobe.v2 v2.0.2 "
	"gopkg.in/vansante/go-ffprobe.v2 v2.0.2/go.mod "
	"gopkg.in/yaml.v2 v2.2.1/go.mod "
	"gopkg.in/yaml.v2 v2.3.0/go.mod "
	"gopkg.in/yaml.v2 v2.4.0 "
	"gopkg.in/yaml.v2 v2.4.0/go.mod "
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c "
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod "
	"maunium.net/go/maulogger/v2 v2.2.4 "
	"maunium.net/go/maulogger/v2 v2.2.4/go.mod "
	"maunium.net/go/mautrix v0.9.26 "
	"maunium.net/go/mautrix v0.9.26/go.mod "
	"maunium.net/go/mauview v0.1.2 "
	"maunium.net/go/mauview v0.1.2/go.mod "
	"maunium.net/go/tcell v0.2.0 "
	"maunium.net/go/tcell v0.2.0/go.mod "
)

go-module_set_globals

SRC_URI="https://github.com/tulir/gomuks/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${EGO_SUM_SRC_URI}"
KEYWORDS="amd64 ~arm64 ~ppc64 ~x86"

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