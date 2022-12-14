# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="The OpenBSD network swiss army knife"
HOMEPAGE="https://cvsweb.openbsd.org/src/usr.bin/nc/
	https://salsa.debian.org/debian/netcat-openbsd"
SRC_URI="http://http.debian.net/debian/pool/main/n/netcat-openbsd/netcat-openbsd_${PV}.orig.tar.gz
	http://http.debian.net/debian/pool/main/n/netcat-openbsd/netcat-openbsd_${PV}-2.debian.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="virtual/pkgconfig"
RDEPEND="!elibc_Darwin? ( dev-libs/libbsd )
	!net-analyzer/netcat
	!net-analyzer/netcat6
"

S=${WORKDIR}/netcat-openbsd-${PV}

src_prepare() {
	for i_patch in $(<"${WORKDIR}"/debian/patches/series); do
		eapply "${WORKDIR}"/debian/patches/"${i_patch}"
	done
	if [[ ${CHOST} == *-darwin* ]] ; then
		# this undoes some of the Debian/Linux changes
		eapply "${FILESDIR}"/${PN}-1.195-darwin.patch
		if [[ ${CHOST##*-darwin} -lt 20 ]] ; then
			eapply "${FILESDIR}"/${PN}-1.190-darwin13.patch
		fi
	fi
	if use elibc_musl ; then
		eapply "${FILESDIR}"/${PN}-1.105-musl-b64_ntop.patch
	fi
	default
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin nc
	doman nc.1
	cd "${WORKDIR}"/debian || die
	newdoc netcat-openbsd.README.Debian README
	dodoc -r examples
}

pkg_postinst() {
	if [[ ${KERNEL} = "linux" ]]; then
		ewarn "SO_REUSEPORT is introduced in linux 3.9. If your running kernel is older"
		ewarn "and kernel header is newer, nc will not listen correctly. Matching the header"
		ewarn "to the running kernel will do. See bug #490246 for details."
	fi
}
