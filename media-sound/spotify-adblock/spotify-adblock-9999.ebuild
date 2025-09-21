# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Use cargo.eclass for Rust projects
inherit cargo git-r3

DESCRIPTION="Spotify adblocker for Linux"
HOMEPAGE="https://github.com/abba23/spotify-adblock"
EGIT_REPO_URI="https://github.com/abba23/spotify-adblock.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-lang/rust
	dev-util/cargo
"
RDEPEND=""

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

