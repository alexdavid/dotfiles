#!/usr/bin/env bash

printf "​"

if pamixer --get-mute > /dev/null; then
  echo ""
  exit 0
fi

VOL=$(pamixer --get-volume)
if [ "$VOL" -lt 25 ]; then echo ""
elif [ "$VOL" -lt 40 ]; then echo ""
elif [ "$VOL" -lt 70 ]; then echo ""
else echo ""
fi
