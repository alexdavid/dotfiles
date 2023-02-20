#!/usr/bin/env bash

set -e
cd ~/.config

git subtree pull \
  --prefix "nvim/bundle/$(basename $1)" \
  "$1" \
 master --squash
