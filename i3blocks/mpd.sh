#!/usr/bin/env bash

if [ -e ~/.config/mpd/host ]; then
  MPD_HOST=$(cat ~/.config/mpd/host)
else
  MPD_HOST="localhost"
fi

mpc -h "$MPD_HOST" current
