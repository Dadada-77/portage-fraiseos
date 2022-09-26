# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson-multilib toolchain-funcs git-r3

DESCRIPTION="Ubuntu community theme \"yaru\"."
HOMEPAGE="https://github.com/ubuntu/yaru"
AUTHOR="ubuntu"

EGIT_REPO_URI="https://github.com/${AUTHOR}/${PN}.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="metacity gnome gtk icons gtksourceview sounds sessions unity xfce cinnamon"

DEPEND="
	dev-vcs/git
"
RDEPEND="
	dev-lang/sassc
	x11-themes/gtk-engines-murrine
	x11-themes/gnome-themes-standard
"

src_configure() {
	local emesonargs=(
		$(meson_native_use_bool metacity)
		$(meson_native_use_bool gnome gnome-shell)
		$(meson_native_use_bool gtk)
		$(meson_native_use_bool icons)
		$(meson_native_use_bool gtksourceview)
		$(meson_native_use_bool sounds)
		$(meson_native_use_bool sessions)
		$(meson_native_use_bool unity ubuntu-unity)
		$(meson_native_use_bool xfce xfwm4)
		$(meson_native_use_bool cinnamon cinnamon)
		$(meson_native_use_bool cinnamon cinnamon-shell)
		$(meson_native_use_bool cinnamon cinnamon-dark)
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
}
src_install() {
	meson_src_install
}
