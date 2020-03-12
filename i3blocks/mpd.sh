#!/usr/bin/env bash

if mpc status | grep playing > /dev/null; then
  printf " "
  mpc current
fi
