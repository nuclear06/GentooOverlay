EAPI=8

inherit git-r3

DESCRIPTION="A wrapper script for launching Touhou games on Steam with thcrap"
HOMEPAGE="https://github.com/nerusuki/thcrap-steam-proton-wrapper"
EGIT_REPO_URI="https://github.com/nerusuki/thcrap-steam-proton-wrapper.git"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS=""

RDEPEND="
	|| ( app-arch/libarchive app-arch/unzip )
	gnome-extra/zenity
	net-misc/curl
"

src_install() {
	dobin thcrap_proton
	einstalldocs
}

pkg_postinst() {
	elog "To use this wrapper, edit the launch options of your Steam game:"
	elog "    thcrap_proton -- %command%"
	elog ""
	elog "Optional flags (place before '--'):"
	elog "  -v    Enable vpatch (Note: vpatch must be installed manually)"
	elog "  -p    Enable thprac (Auto-downloads thprac to ~/.local/share/thprac)"
	elog ""
	elog "Configuration:"
	elog "You can change THCRAP_FOLDER or THCRAP_CONFIG by editing the script at:"
	elog "    ${EROOT}/usr/bin/thcrap_proton"
}
