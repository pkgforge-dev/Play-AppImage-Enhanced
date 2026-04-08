#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
     cmake              \
     glew               \
     hicolor-icon-theme \
     kvantum            \
     lxqt-qtplugin      \
     nlohmann-json      \
     openal             \
     qt6-base           \
     qt6ct              \
     vulkan-icd-loader 

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Building Play!..."
echo "---------------------------------------------------------------"
REPO="https://github.com/jpd002/Play-.git"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --recursive --depth 1 "$REPO" ./Play
echo "$VERSION" > ~/version


cmake -B build -S ./Play \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DWITH_SYSTEM_ZLIB=ON
cmake --build build
cmake --install build
