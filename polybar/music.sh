#!/usr/bin/env bash

if ! playerctl status > /dev/null; then
  exit 0
fi

if [[ $(playerctl status) != "Paused" ]]; then
  echo "  $(playerctl metadata title) / $(playerctl metadata artist)"
fi
