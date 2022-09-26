# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#inherit autotools

DESCRIPTION="FraiseOS Kernel"
HOMEPAGE="https://www.gentoo.org/"
SRC_URI="10.0.2.15:///var/cache/distfiles/${PN}-${PV}.tar.xz"
LICENSE="GPL-2"
KEYWORDS="amd64"
SLOT="0"
S="${WORKDIR}"

RDEPEND="
	sys-kernel/dracut
"

src_install() {
	insinto /boot
	doins "${S}/boot/vmlinuz-linux.efi" || die
	insinto /lib/modules
	for i in $(ls "${S}/lib/modules"); do
		doins -r "${S}/lib/modules/${i}" || die
	done
}

pkg_postinst() {
	dracut --hostonly --kver ${PV}-xanmod1 --force /boot/initramfs-linux.img
}
