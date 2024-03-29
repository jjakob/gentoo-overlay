# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for Message Transfer Agents"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"

# mail-mta/citadel is from sunrise
RDEPEND="|| (	mail-mta/nullmailer
				mail-mta/msmtp[mta]
				mail-mta/ssmtp[mta]
				mail-mta/courier
				mail-mta/esmtp
				mail-mta/exim
				mail-mta/netqmail
				mail-mta/notqmail
				mail-mta/postfix
				mail-mta/sendmail
				mail-mta/opensmtpd[mta]
				mail-mta/dma[mta]
				)"
