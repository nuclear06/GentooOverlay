# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="A friendlier ss/netstat for humans"
HOMEPAGE="https://github.com/karol-broda/snitch"
EGIT_REPO_URI="https://github.com/karol-broda/snitch.git"

LICENSE="MIT"
LICENSE+=" Apache-2.0 BSD-2 BSD ISC MIT Unlicense "
SLOT="0"
KEYWORDS=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	export CGO_ENABLED=0

	local git_commit
	local build_date=$(date -u +%Y-%m-%dT%H:%M:%SZ)
	git_commit=$(git rev-parse --short HEAD)

	ego build -o snitch \
		-ldflags "-X snitch/cmd.Version=${PV} -X snitch/cmd.Commit=${git_commit} -X snitch/cmd.Date=${build_date}" \
		.
}

src_test() {
	ego test ./...
}

src_install() {
	dobin snitch
}
