#!/usr/bin/env bash

(
  # checkupdates fails if it is run in parallel so we add a mutex
  # here to make sure only one update.sh is run at a time
  flock -w 10 200

  updates=$(checkupdates | wc -l)

  if [ "$updates" -gt 0 ]; then
    echo " $updates"
  else
    echo ""
  fi
) 200>~/.config/polybar/update.lock
