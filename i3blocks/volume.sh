#!/usr/bin/env bash

printf "​"

if [ "$(pulsemixer --get-mute)" -eq 1 ] ; then
  echo ""
  exit 0
fi

VOL=$(pulsemixer --get-volume | awk '{ print ($1+$2)/2 }')
if [ "$VOL" -lt 25 ]; then echo ""
elif [ "$VOL" -lt 40 ]; then echo ""
elif [ "$VOL" -lt 70 ]; then echo ""
else echo ""
fi
