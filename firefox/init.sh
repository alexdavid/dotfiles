#!/usr/bin/env bash

set -e
shopt -s nullglob

for PROFILE_DIR in \
  ~/.mozilla/firefox/*.default \
  ~/.mozilla/firefox/*.default-release \
  ~/.mozilla/firefox/*.dev-edition-default \
; do
  echo "=== Installing in $PROFILE_DIR ==="
  mkdir -p "$PROFILE_DIR/chrome"
  if [ ! -e "$PROFILE_DIR/chrome/userChrome.css" ]; then
    ln -s ~/.config/firefox/userChrome.css "$PROFILE_DIR/chrome/userChrome.css"
  else
    echo "userChrome.css already exists. Skipping..."
  fi
done
