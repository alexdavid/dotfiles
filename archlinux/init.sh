#!/usr/bin/env bash

set -e
cd $(dirname $0)

for PKGBUILD in "$@"; do
  echo "Installing $PKGBUILD"
  makepkg -sic -p "$PKGBUILD"
done

rm *.pkg.tar.zst
