# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module toolchain-funcs

DESCRIPTION="A tool for redirecting a given program's TCP traffic to SOCKS5 or HTTP proxy"
HOMEPAGE="https://github.com/hmgle/graftcp"
SRC_URI="https://github.com/hmgle/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/nuclear06/gentoo-deps/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="GPL-3+"
# Go dependency licenses
LICENSE+=" Apache-2.0 BSD BSD-2 MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

BDEPEND=">=dev-lang/go-1.23"

DOCS=(
  README{,.zh-CN}.md
  example-{black,white}list-ip.txt
  example-{graftcp,mgraftcp}.conf
)

# Written in Go (CGO)
QA_FLAGS_IGNORED="
	usr/bin/graftcp
	usr/bin/mgraftcp
"

# skip ego mod
src_unpack() {
  default
}

src_prepare() {
  default
  pushd local >/dev/null || die
  GOMODCACHE="${WORKDIR}/go-mod" ego mod verify
  popd >/dev/null || die
}

src_compile() {
  local mymakeargs=(
    VERSION="v${PV}"
    CC="$(tc-getCC)"
    AR="$(tc-getAR)"
    CFLAGS="${CFLAGS} -DNDEBUG"
    GO_MOD_CACHE_DIR="${WORKDIR}/go-mod"
  )
  emake "${mymakeargs[@]}"
}

src_install() {
  local mymakeargs=(
    DESTDIR="${D}"
    PREFIX="${EPREFIX}/usr"
  )
  emake -j1 "${mymakeargs[@]}" install

  insinto /etc/graftcp
  doins example-graftcp.conf

  einstalldocs
}
