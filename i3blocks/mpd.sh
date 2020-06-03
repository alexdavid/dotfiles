#!/usr/bin/env bash

while true; do
  if ! mpc idle > /dev/null; then
    sleep 120
  fi
  if mpc status | grep playing > /dev/null; then
    echo " $(mpc current)"
  else
    echo
  fi
done
