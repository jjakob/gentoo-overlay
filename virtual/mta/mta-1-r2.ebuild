# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for Message Transfer Agents"
SLOT="0"
KEYWORDS="~amd64"

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
