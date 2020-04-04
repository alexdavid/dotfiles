#!/usr/bin/env bash

which mpc &> /dev/null || exit 0

if mpc status | grep playing > /dev/null; then
  printf " "
  mpc current
fi
