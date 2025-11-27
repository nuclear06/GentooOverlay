# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="CLI tool for interacting with Forgejo"
HOMEPAGE="https://codeberg.org/forgejo-contrib/forgejo-cli"
EGIT_REPO_URI="https://codeberg.org/forgejo-contrib/forgejo-cli.git"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-libs/openssl:=
	sys-libs/zlib
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	cargo_src_install
	einstalldocs
}
