EAPI=8

inherit optfeature unpacker xdg

DESCRIPTION="Ente's 2FA solution"
HOMEPAGE="https://ente.io/blog/auth/"
MY_PV="${PV/_beta/}"
SRC_URI="
	amd64? (
		https://github.com/ente-io/ente/releases/download/auth-v${MY_PV}/ente-auth-v${MY_PV}-x86_64.deb -> ${P}-amd64.deb
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
	sys-auth/polkit
	virtual/zlib
	x11-misc/xdg-user-dirs
"

src_prepare() {
	default
}

src_install() {
	# Copy all unpacked files from the deb archive
	cp -a usr "${ED}/" || die "Failed to install files"

	# Set correct permissions
	chmod +x "${ED}/usr/share/enteauth/enteauth" || die
	chmod +x "${ED}/usr/share/enteauth/lib"/*.so || die

	# Create executable symlink
	dodir /usr/bin
	dosym ../share/enteauth/enteauth /usr/bin/enteauth

	# Install polkit policy
	insinto /usr/share/polkit-1/actions
	doins usr/share/enteauth/data/flutter_assets/assets/polkit/com.ente.auth.policy
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "importing files" gnome-extra/zenity
}

pkg_postrm() {
	xdg_pkg_postrm
}
