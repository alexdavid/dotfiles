#!/usr/bin/env bash

if [ -n "$BLOCK_BUTTON" ]; then
  systemctl --user stop xdg-desktop-portal-wlr
fi

if systemctl --user status xdg-desktop-portal-wlr > /dev/null; then
  echo "Stop Screen Share"
  echo "S"
  echo "#FF0000"
fi
