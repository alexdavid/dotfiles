#!/usr/bin/env bash

which khal || exit

event="$(khal list --day-format '' --format '{title} @ {start-time}' now eod)"
if [ "$event" != "No events" ]; then
  echo " $event" | tail +1
fi
