#!/usr/bin/env bash

which acpi &> /dev/null || exit 0

PERCENT=$(acpi -b | sed -E 's/.+, ([0-9]+)%.*/\1/')
STATUS=$(acpi -b | sed -E 's/.+: (\w+),.+/\1/')

if [ "$STATUS" = Charging ]; then
  ICON=""
  COLOR="#FFFFFF"
elif [ "$PERCENT" -lt 28 ]; then
  ICON=""
  COLOR="#FF0000"
elif [ "$PERCENT" -lt 56 ]; then
  ICON=""
  COLOR="#FFFFFF"
elif [ "$PERCENT" -lt 84 ]; then
  ICON=""
  COLOR="#FFFFFF"
else
  ICON=""
  COLOR="#FFFFFF"
fi

echo "$ICON $PERCENT%"
echo "$ICON"
echo "$COLOR"
