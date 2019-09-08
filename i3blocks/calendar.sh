#!/usr/bin/env bash

event="$(khal list --day-format '' --format '{title} @ {start-time}' now eod)"
if [ "$event" != "No events" ]; then
  echo " $event" | tail +1
fi
