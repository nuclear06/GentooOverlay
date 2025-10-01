# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Adblocker for Spotify"
HOMEPAGE="https://github.com/abba23/spotify-adblock"
EGIT_REPO_URI="https://github.com/abba23/spotify-adblock.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_compile() {
	cargo_src_compile
}

src_install() {
	insinto /usr/$(get_libdir)
	newins target/release/libspotifyadblock.so spotify-adblock.so

	insinto /etc/${PN}
	doins config.toml
}

pkg_postinst() {
	elog "The spotify-adblock shared library has been installed to:"
	elog "  /usr/$(get_libdir)/spotify-adblock.so"
	elog
	elog "To use it with Spotify, set LD_PRELOAD, for example:"
	elog "  LD_PRELOAD=/usr/$(get_libdir)/spotify-adblock.so spotify"
	elog
	elog "The default configuration file is located at:"
	elog "  /etc/${PN}/config.toml"
}
