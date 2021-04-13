# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Dragonfly Mail Agent"
HOMEPAGE="https://github.com/corecode/dma"
LICENSE="BSD"
SLOT="0"
IUSE="+mta"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/jjakob/${PN}.git"
	EGIT_BRANCH="rewriteheaderfrom"
	inherit git-r3
else
	SRC_URI="https://github.com/corecode/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

# build programs
BDEPEND="
	sys-devel/bison
	sys-devel/flex
"

# build libraries and headers
DEPEND="
	dev-libs/openssl
"

# runtime
RDEPEND="
	$DEPEND
	acct-user/mail
	acct-group/mail
	mta? (
		!mail-mta/courier
		!mail-mta/esmtp
		!mail-mta/exim
		!mail-mta/mini-qmail
		!mail-mta/netqmail
		!mail-mta/nullmailer
		!mail-mta/postfix
		!mail-mta/qmail-ldap
		!mail-mta/sendmail
		!mail-mta/opensmtpd
		!<mail-mta/ssmtp-2.64-r2
		!>=mail-mta/ssmtp-2.64-r2[mta]
		!mail-mta/msmtp[mta]
	)

"

src_install() {
	exeopts -m 2755 -o root -g mail
	exeinto /usr/sbin
	doexe dma
	exeopts -m 4754 -o root -g mail
	exeinto /usr/libexec
	doexe dma-mbox-create

	diropts -m 2755 -o root -g mail
	keepdir /var/spool/dma
	keepdir /var/mail

	insinto /etc/dma
	insopts -m 644 -o root -g mail
	doins dma.conf
	insopts -m 640 -o root -g mail
	doins auth.conf

	insinto /etc/cron.d
	insopts -m 644
	newins "${FILESDIR}"/dma.cron dma

	doman dma.8

	if use mta; then
		dosym dma /usr/sbin/sendmail
		dosym dma /usr/sbin/mailq
	fi
}
