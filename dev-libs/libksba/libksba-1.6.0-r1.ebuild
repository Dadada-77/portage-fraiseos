# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="X.509 and CMS (PKCS#7) library"
HOMEPAGE="https://www.gnupg.org/related_software/libksba"
SRC_URI="mirror://gnupg/libksba/${P}.tar.bz2"

LICENSE="LGPL-3+ GPL-2+ GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs"

RDEPEND=">=dev-libs/libgpg-error-1.8"
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/bison"

PATCHES=(
	"${FILESDIR}"/${PN}-1.6.0-no-fgrep-ksba-config.patch
)

src_configure() {
	local myeconfargs=(
		$(use_enable static-libs static)
		GPG_ERROR_CONFIG="${ESYSROOT}/usr/bin/${CHOST}-gpg-error-config"
		LIBGCRYPT_CONFIG="${ESYSROOT}/usr/bin/${CHOST}-libgcrypt-config"
		$("${S}/configure" --help | grep -o -- '--without-.*-prefix')
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default

	# People need to use ksba-config for --cflags and --libs
	find "${ED}" -type f -name '*.la' -delete || die
}
