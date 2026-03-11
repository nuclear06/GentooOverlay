EAPI=8

DESCRIPTION="Ente's 2FA solution"
HOMEPAGE="https://ente.io/blog/auth/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	sys-libs/glibc
	sys-libs/zlib
	x11-libs/gtk+:3
	dev-libs/libayatana-appindicator
	app-crypt/libsecret
	dev-libs/openssl
	media-libs/libepoxy
	net-misc/curl
"

S="${WORKDIR}"
RESTRICT="strip"

inherit xdg-utils
MY_PV="${PV/_/-}"

SRC_URI="
  amd64? ( https://github.com/ente-io/ente/releases/download/auth-v${MY_PV}/ente-auth-v${MY_PV}-x86_64.AppImage -> ${P}-amd64.AppImage )
"

src_unpack() {
  cp "${DISTDIR}/${P}-amd64.AppImage" "ente_auth.AppImage" || die "Can't copy downloaded file"
  chmod +x "ente_auth.AppImage" || die "Can't chmod AppImage"
  ./ente_auth.AppImage --appimage-extract || die "Failed to extract appimage"
}

src_prepare() {
  sed -i 's:^Exec=.*:Exec=/opt/bin/enteauth:' 'squashfs-root/enteauth.desktop'
  eapply_user
}

src_install() {
  # skip appimage, directly run binary
  # https://github.com/ente-io/ente/issues/6705
  dodir /opt/enteauth
  cp -a squashfs-root/{lib,data,enteauth} "${ED}/opt/enteauth/" || die "Failed to copy app resources"

  dodir /opt/bin
  cat >>"${T}/enteauth" <<-EOF
#!/bin/sh
cd "/opt/enteauth" || exit 1
exec ./enteauth "\$@"
EOF

  exeinto /opt/bin
  doexe "${T}/enteauth"

  insinto /usr/share/applications
  doins "squashfs-root/enteauth.desktop"

  insinto /usr/share/icons
  doins -r squashfs-root/usr/share/icons/hicolor

  insinto /usr/share/pixmaps
  doins squashfs-root/*.png
}

pkg_postinst() {
  xdg_desktop_database_update
}

pkg_postrm() {
  xdg_desktop_database_update
}
