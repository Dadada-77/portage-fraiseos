# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Locales support for musl"
HOMEPAGE="https://git.adelielinux.org/adelie/musl-locales/-/wikis/home"
SRC_URI="https://git.adelielinux.org/adelie/musl-locales/-/archive/${PV}/${P}.tar.bz2"
S="${WORKDIR}/${P}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/cmake
	sys-devel/gettext
"
