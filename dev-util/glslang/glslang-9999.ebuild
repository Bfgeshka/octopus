## Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-multilib cmake git-r3

## This is a workaround. As for 19.10.19, live ebuild fails due to cmake error.
## EGIT_COMMIT="8ba49b862cfb3449ffdfecd2e6d9c2fd5e855f1e"
EGIT_REPO_URI="https://github.com/KhronosGroup/glslang.git"
SRC_URI=""

DESCRIPTION="Khronos reference front-end for GLSL and ESSL, and sample SPIR-V generator"
HOMEPAGE="https://www.khronos.org/opengles/sdk/tools/Reference-Compiler/"

LICENSE="BSD"
SLOT="0"

PATCHES=(
#	"${FILESDIR}/glslang-revert-b03e4fc4e072c997b19e4425a0a8fc3c5b280685.patch"
)
