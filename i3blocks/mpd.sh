#!/usr/bin/env bash

which mpc &> /dev/null || exit 0

while true; do
  if mpc status | grep playing > /dev/null; then
    echo " $(mpc current)"
  else
    echo
  fi
  mpc idle > /dev/null
done
