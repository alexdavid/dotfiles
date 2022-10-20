#!/usr/bin/env bash

which khal &> /dev/null || exit 0

event="$(khal list --day-format '' --format '{start-time} {title}' now eod)"
if [ "$event" != "No events" ]; then
  echo " $event" | head -n1
fi
