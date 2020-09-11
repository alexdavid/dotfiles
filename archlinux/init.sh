#!/usr/bin/env bash

set -e
cd $(dirname $0)

makepkg -si -p "PKGBUILD-$1"
rm *.pkg.tar.zst
