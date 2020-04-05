#!/usr/bin/env bash

if pamixer --get-mute > /dev/null; then
  echo ""
  exit 0
fi

VOL=$(pamixer --get-volume)
if [ "$VOL" -lt 25 ]; then
  ICON=""
elif [ "$VOL" -lt 40 ]; then
  ICON=""
elif [ "$VOL" -lt 70 ]; then
  ICON=""
else
  ICON=""
fi

echo "$ICON $VOL%"
echo "$ICON"
