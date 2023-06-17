# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Pure-python wrapper for libusb-1.0"
HOMEPAGE="https://github.com/vpelletier/python-libusb1"

SRC_URI="https://github.com/vpelletier/python-libusb1/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/python-libusb1-${PV}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="virtual/libusb"

distutils_enable_tests setup.py

python_prepare_all(){
	distutils-r1_python_prepare_all

	rm -r usb1/__pyinstaller || die
}

python_install_all(){
	use examples && dodoc -r examples

	distutils-r1_python_install_all
}
