EAPI=8

inherit desktop xdg

DESCRIPTION="Ente's 2FA solution"
HOMEPAGE="https://ente.io/blog/auth/"
MY_PV="${PV/_/-}"
APPIMAGE_URI="https://github.com/ente-io/ente/releases/download/auth-v${MY_PV}/ente-auth-v${MY_PV}-x86_64.AppImage"
SRC_URI="
	amd64? (
		${APPIMAGE_URI} -> ${P}-amd64.AppImage
	)
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

RDEPEND="
	elibc_glibc? ( sys-libs/glibc )
	x11-libs/gtk+:3
	dev-libs/libayatana-appindicator
	app-crypt/libsecret
	dev-libs/openssl
	media-libs/libepoxy
	net-misc/curl
	virtual/zlib
"

src_unpack() {
	cp "${DISTDIR}/${P}-amd64.AppImage" "ente_auth.AppImage" || die "Can't copy downloaded file"
	chmod +x "ente_auth.AppImage" || die "Can't chmod AppImage"
	./ente_auth.AppImage --appimage-extract || die "Failed to extract appimage"
}

src_prepare() {
	sed -i 's:^Exec=.*:Exec=/opt/bin/enteauth:' squashfs-root/enteauth.desktop || die
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

	domenu squashfs-root/enteauth.desktop

	insinto /usr/share/icons
	doins -r squashfs-root/usr/share/icons/hicolor

	insinto /usr/share/pixmaps
	doins squashfs-root/*.png
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
