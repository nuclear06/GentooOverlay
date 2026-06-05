# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="A preloader which hooks calls to sockets in dynamically linked programs"
HOMEPAGE="https://github.com/rofl0r/proxychains-ng"
EGIT_REPO_URI="https://github.com/rofl0r/proxychains-ng.git"

LICENSE="GPL-2+"
SLOT="0"
IUSE="test"

src_configure() {
  tc-export CC
  ./configure \
    --prefix="${EPREFIX}/usr" \
    --sysconfdir="${EPREFIX}/etc" \
    --libdir="${EPREFIX}/usr/$(get_libdir)" || die
}

src_compile() {
  emake
}

src_install() {
  emake DESTDIR="${D}" install
  emake DESTDIR="${D}" install-config

  insinto /usr/share/zsh/site-functions
  doins completions/zsh/_proxychains4
}

src_test() {
  emake test
}

pkg_postinst() {
  elog "The default configuration file has been installed to:"
  elog "  ${EPREFIX}/etc/proxychains.conf"
  elog
  elog "You may need to edit it to specify your proxy server."
}
