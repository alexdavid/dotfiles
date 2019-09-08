#!/usr/bin/env bash

if [ -e ~/.config/mpd/host ]; then
  MPD_HOST=$(cat ~/.config/mpd/host)
else
  MPD_HOST="localhost"
fi

if mpc -h "$MPD_HOST" status | grep playing > /dev/null; then
  printf " "
  mpc -h "$MPD_HOST" current
fi
