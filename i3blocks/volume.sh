#!/usr/bin/env bash

if pamixer --get-mute > /dev/null; then
  echo "Mute"
  exit 0
fi

echo "$(pamixer --get-volume)%"
