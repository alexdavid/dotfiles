#!/usr/bin/env bash

if ! playerctl status &> /dev/null; then
  exit 0
fi

echo " $(playerctl status) $(playerctl metadata title) by $(playerctl metadata artist)"
