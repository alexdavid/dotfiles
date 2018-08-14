#!/usr/bin/env bash

updates=$(checkupdates | wc -l)

if [ "$updates" -gt 0 ]; then
  echo "$updates"
fi
