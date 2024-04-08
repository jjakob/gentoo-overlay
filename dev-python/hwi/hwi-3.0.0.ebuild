# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 udev

DESCRIPTION="Library and command line tool for interacting with hardware wallets"
HOMEPAGE="https://github.com/bitcoin-core/HWI"

MY_PN="HWI"
MY_COMMIT="3.0.0"
MY_P="${MY_PN}-${MY_COMMIT}"
SRC_URI="https://github.com/bitcoin-core/HWI/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="udev qt5" # qt5 may work but I haven't tested it

# bitbox02_lib has been added to HWI as a package
#		>=dev-python/bitbox02-6.1[${PYTHON_USEDEP}]
#		<dev-python/bitbox02-7[${PYTHON_USEDEP}]
#		)

RDEPEND="
	=dev-python/cbor2-5*[${PYTHON_USEDEP}]
	=dev-python/ecdsa-0*[${PYTHON_USEDEP}]
	>=dev-python/hidapi-0.14.0[${PYTHON_USEDEP}]
	>=dev-python/libusb1-1.7[${PYTHON_USEDEP}]
	<dev-python/libusb1-4[${PYTHON_USEDEP}]
	=dev-python/mnemonic-0*[${PYTHON_USEDEP}]
	=dev-python/noiseprotocol-0.3*[${PYTHON_USEDEP}]
	=dev-python/protobuf-python-4*[${PYTHON_USEDEP}]
	>=dev-python/pyaes-1.6[${PYTHON_USEDEP}]
	<dev-python/pyaes-2[${PYTHON_USEDEP}]
	>=dev-python/pyserial-3.5[${PYTHON_USEDEP}]
	<dev-python/pyserial-4[${PYTHON_USEDEP}]
	=dev-python/semver-3*[${PYTHON_USEDEP}]
	qt5? ( >=dev-python/pyside2-5.14.0[gui,widgets,${PYTHON_USEDEP}]
			<dev-python/pyside2-6[${PYTHON_USEDEP}]
			=dev-python/pyside2-tools-5*[${PYTHON_USEDEP}]
		)
	"

distutils_enable_tests unittest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme \
	dev-python/sphinxcontrib-autoprogram

pkg_setup() {
	if ! has_version -r ">=dev-libs/hidapi-0.9.0"; then
		eerror "Detected old version of dev-libs/hidapi that doesn't work with latest dev-python/hidapi."
		eerror "https://github.com/bitcoin-core/HWI/issues/462 https://bugs.gentoo.org/696482"
		eerror "Please use accept_keywords to accept a newer version, preferably it should match the dev-python/hidapi version."
		die
	else
		einfo "Checked version of dev-libs/hidapi is OK."
	fi
}

python_prepare_all() {
	if use qt5; then
		contrib/generate-ui.sh || die
	else
		sed -i -e '/hwi-qt/d' pyproject.toml || die
		sed -i -e "s/, 'hwi-qt'//" setup.py || die
	fi

	pushd test 2>/dev/null || die
	# remove tests that require hardware emulation
	rm test_coldcard.py test_device.py test_digitalbitbox.py \
		test_jade.py test_keepkey.py test_ledger.py test_trezor.py || die
	# remove udev tests because it expects the rules are installed in the libs folder
	rm test_udevrules.py || die
	popd || die

	distutils-r1_python_prepare_all
}

python_install_all() {
	use udev && udev_dorules hwilib/udev/*.rules
	use doc  && dodoc -r docs

	distutils-r1_python_install_all
}

pkg_postinst() {
	use udev && udev_reload
}

pkg_postrm() {
	use udev && udev_reload
}
