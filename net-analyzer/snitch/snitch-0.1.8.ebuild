# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A friendlier ss/netstat for humans"
HOMEPAGE="https://github.com/karol-broda/snitch"

# TODO: move to vendor tar
# currently just dont want to maintain a vendor tar file
_EGO_SUM=(
  "github.com/aymanbagabas/go-osc52/v2 v2.0.1"
  "github.com/aymanbagabas/go-osc52/v2 v2.0.1/go.mod"
  "github.com/aymanbagabas/go-udiff v0.3.1"
  "github.com/aymanbagabas/go-udiff v0.3.1/go.mod"
  "github.com/charmbracelet/bubbletea v1.3.6"
  "github.com/charmbracelet/bubbletea v1.3.6/go.mod"
  "github.com/charmbracelet/colorprofile v0.3.2"
  "github.com/charmbracelet/colorprofile v0.3.2/go.mod"
  "github.com/charmbracelet/lipgloss v1.1.0"
  "github.com/charmbracelet/lipgloss v1.1.0/go.mod"
  "github.com/charmbracelet/x/ansi v0.10.1"
  "github.com/charmbracelet/x/ansi v0.10.1/go.mod"
  "github.com/charmbracelet/x/cellbuf v0.0.13-0.20250311204145-2c3ea96c31dd"
  "github.com/charmbracelet/x/cellbuf v0.0.13-0.20250311204145-2c3ea96c31dd/go.mod"
  "github.com/charmbracelet/x/exp/golden v0.0.0-20240806155701-69247e0abc2a"
  "github.com/charmbracelet/x/exp/golden v0.0.0-20240806155701-69247e0abc2a/go.mod"
  "github.com/charmbracelet/x/exp/teatest v0.0.0-20251215102626-e0db08df7383"
  "github.com/charmbracelet/x/exp/teatest v0.0.0-20251215102626-e0db08df7383/go.mod"
  "github.com/charmbracelet/x/term v0.2.1"
  "github.com/charmbracelet/x/term v0.2.1/go.mod"
  "github.com/cpuguy83/go-md2man/v2 v2.0.6/go.mod"
  "github.com/davecgh/go-spew v1.1.0/go.mod"
  "github.com/davecgh/go-spew v1.1.1/go.mod"
  "github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc"
  "github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc/go.mod"
  "github.com/erikgeiser/coninput v0.0.0-20211004153227-1c3628e74d0f"
  "github.com/erikgeiser/coninput v0.0.0-20211004153227-1c3628e74d0f/go.mod"
  "github.com/fatih/color v1.18.0"
  "github.com/fatih/color v1.18.0/go.mod"
  "github.com/frankban/quicktest v1.14.6"
  "github.com/frankban/quicktest v1.14.6/go.mod"
  "github.com/fsnotify/fsnotify v1.7.0"
  "github.com/fsnotify/fsnotify v1.7.0/go.mod"
  "github.com/google/go-cmp v0.5.9"
  "github.com/google/go-cmp v0.5.9/go.mod"
  "github.com/hashicorp/hcl v1.0.0"
  "github.com/hashicorp/hcl v1.0.0/go.mod"
  "github.com/inconshreveable/mousetrap v1.1.0"
  "github.com/inconshreveable/mousetrap v1.1.0/go.mod"
  "github.com/kr/pretty v0.3.1"
  "github.com/kr/pretty v0.3.1/go.mod"
  "github.com/kr/text v0.2.0"
  "github.com/kr/text v0.2.0/go.mod"
  "github.com/lucasb-eyer/go-colorful v1.2.0"
  "github.com/lucasb-eyer/go-colorful v1.2.0/go.mod"
  "github.com/magiconair/properties v1.8.7"
  "github.com/magiconair/properties v1.8.7/go.mod"
  "github.com/mattn/go-colorable v0.1.13"
  "github.com/mattn/go-colorable v0.1.13/go.mod"
  "github.com/mattn/go-isatty v0.0.16/go.mod"
  "github.com/mattn/go-isatty v0.0.20"
  "github.com/mattn/go-isatty v0.0.20/go.mod"
  "github.com/mattn/go-localereader v0.0.1"
  "github.com/mattn/go-localereader v0.0.1/go.mod"
  "github.com/mattn/go-runewidth v0.0.16"
  "github.com/mattn/go-runewidth v0.0.16/go.mod"
  "github.com/mitchellh/mapstructure v1.5.0"
  "github.com/mitchellh/mapstructure v1.5.0/go.mod"
  "github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6"
  "github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6/go.mod"
  "github.com/muesli/cancelreader v0.2.2"
  "github.com/muesli/cancelreader v0.2.2/go.mod"
  "github.com/muesli/termenv v0.16.0"
  "github.com/muesli/termenv v0.16.0/go.mod"
  "github.com/pelletier/go-toml/v2 v2.2.2"
  "github.com/pelletier/go-toml/v2 v2.2.2/go.mod"
  "github.com/pmezard/go-difflib v1.0.0/go.mod"
  "github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2"
  "github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2/go.mod"
  "github.com/rivo/uniseg v0.2.0/go.mod"
  "github.com/rivo/uniseg v0.4.7"
  "github.com/rivo/uniseg v0.4.7/go.mod"
  "github.com/rogpeppe/go-internal v1.9.0"
  "github.com/rogpeppe/go-internal v1.9.0/go.mod"
  "github.com/russross/blackfriday/v2 v2.1.0/go.mod"
  "github.com/sagikazarmark/locafero v0.4.0"
  "github.com/sagikazarmark/locafero v0.4.0/go.mod"
  "github.com/sagikazarmark/slog-shim v0.1.0"
  "github.com/sagikazarmark/slog-shim v0.1.0/go.mod"
  "github.com/sourcegraph/conc v0.3.0"
  "github.com/sourcegraph/conc v0.3.0/go.mod"
  "github.com/spf13/afero v1.11.0"
  "github.com/spf13/afero v1.11.0/go.mod"
  "github.com/spf13/cast v1.6.0"
  "github.com/spf13/cast v1.6.0/go.mod"
  "github.com/spf13/cobra v1.9.1"
  "github.com/spf13/cobra v1.9.1/go.mod"
  "github.com/spf13/pflag v1.0.6"
  "github.com/spf13/pflag v1.0.6/go.mod"
  "github.com/spf13/viper v1.19.0"
  "github.com/spf13/viper v1.19.0/go.mod"
  "github.com/stretchr/objx v0.1.0/go.mod"
  "github.com/stretchr/objx v0.4.0/go.mod"
  "github.com/stretchr/objx v0.5.0/go.mod"
  "github.com/stretchr/objx v0.5.2/go.mod"
  "github.com/stretchr/testify v1.3.0/go.mod"
  "github.com/stretchr/testify v1.7.1/go.mod"
  "github.com/stretchr/testify v1.8.0/go.mod"
  "github.com/stretchr/testify v1.8.4/go.mod"
  "github.com/stretchr/testify v1.9.0"
  "github.com/stretchr/testify v1.9.0/go.mod"
  "github.com/subosito/gotenv v1.6.0"
  "github.com/subosito/gotenv v1.6.0/go.mod"
  "github.com/tidwall/pretty v1.2.1"
  "github.com/tidwall/pretty v1.2.1/go.mod"
  "github.com/xo/terminfo v0.0.0-20220910002029-abceb7e1c41e"
  "github.com/xo/terminfo v0.0.0-20220910002029-abceb7e1c41e/go.mod"
  "go.uber.org/atomic v1.9.0"
  "go.uber.org/atomic v1.9.0/go.mod"
  "go.uber.org/multierr v1.9.0"
  "go.uber.org/multierr v1.9.0/go.mod"
  "golang.org/x/exp v0.0.0-20231006140011-7918f672742d"
  "golang.org/x/exp v0.0.0-20231006140011-7918f672742d/go.mod"
  "golang.org/x/sync v0.16.0"
  "golang.org/x/sync v0.16.0/go.mod"
  "golang.org/x/sys v0.0.0-20210809222454-d867a43fc93e/go.mod"
  "golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
  "golang.org/x/sys v0.6.0/go.mod"
  "golang.org/x/sys v0.39.0"
  "golang.org/x/sys v0.39.0/go.mod"
  "golang.org/x/term v0.38.0"
  "golang.org/x/term v0.38.0/go.mod"
  "golang.org/x/text v0.28.0"
  "golang.org/x/text v0.28.0/go.mod"
  "gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
  "gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15"
  "gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod"
  "gopkg.in/ini.v1 v1.67.0"
  "gopkg.in/ini.v1 v1.67.0/go.mod"
  "gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
  "gopkg.in/yaml.v3 v3.0.1"
  "gopkg.in/yaml.v3 v3.0.1/go.mod"
)

if [[ "${PV}" == 9999 ]]; then
  inherit git-r3
  KEYWORDS=""
  EGIT_REPO_URI="https://github.com/karol-broda/snitch.git"
else
  EGO_SUM=("${_EGO_SUM[@]}")
  go-module_set_globals
  KEYWORDS="~amd64"
  SRC_URI="https://github.com/karol-broda/snitch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
    ${EGO_SUM_SRC_URI}"
fi

LICENSE="MIT"
LICENSE+=" Apache-2.0 BSD-2 BSD ISC MIT Unlicense "
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
  if [[ "${PV}" == 9999 ]]; then
    git-r3_src_unpack
    go-module_live_vendor
  else
    go-module_src_unpack
  fi
}

src_compile() {
  export CGO_ENABLED=0

  local git_commit
  local build_date=$(date -u +%Y-%m-%dT%H:%M:%SZ)

  if [[ "${PV}" == 9999 ]]; then
    git_commit=$(git rev-parse --short HEAD)
  else
    git_commit="v${PV}"
  fi

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
