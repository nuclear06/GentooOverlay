# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="A truely minimal markdown editor."
HOMEPAGE="https://typora.io"
SRC_URI="https://download.typora.io/linux/typora_${PV}_amd64.deb
	tgreen? ( https://github.com/Delppine1024/TGreen/releases/download/v${PV}/app_asar_file_v${PV}.zip )"

S="${WORKDIR}"

LICENSE="typora"
SLOT="0"
KEYWORDS="~amd64"
IUSE="tgreen wayland"

RESTRICT="mirror splitdebug"

RDEPEND="
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	net-print/cups
	x11-libs/libXScrnSaver
"

QA_PREBUILT="*"

src_unpack() {
  # Unpack the main deb file
  unpack typora_${PV}_amd64.deb
  unpack ./data.tar.xz

  # Unpack the patch file if tgreen USE flag is enabled
  if use tgreen; then
    unpack app_asar_file_v${PV}.zip
  fi
}

src_install() {
  mv "${S}/usr" "${D}" || die

  # fix fcitx5 input method issue on wayland
  if use wayland; then
    rm "${D}/usr/bin/typora" || die
    cat > "${T}/typora" <<EOF
#!/bin/sh
exec /usr/share/typora/Typora --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime "\$@"
EOF
    dobin "${T}/typora"
  fi

  if use tgreen; then
    if [[ -f "${S}/app.asar" ]]; then
      cp "${S}/app.asar" "${D}/usr/share/typora/resources/" || die "Failed to install patched app.asar"
    else
      die "Patched app.asar file not found"
    fi
  fi

  pushd "${D}/usr/share/doc" >/dev/null || die
  mv ${PN} ${P} || die
  popd >/dev/null || die
}
