# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

inherit cargo

DESCRIPTION="CLI tool for interacting with Forgejo"
HOMEPAGE="https://codeberg.org/forgejo-contrib/forgejo-cli"
SRC_URI="https://codeberg.org/forgejo-contrib/forgejo-cli/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/openssl:=
	sys-libs/zlib
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

# Rust binaries often have issues with QA checks regarding strict aliasing or LTO,
# and sometimes text relocations (though less common now).
# QA_FLAGS_IGNORED="usr/bin/fj"

src_install() {
	cargo_src_install
	einstalldocs
}
