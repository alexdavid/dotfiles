#!/usr/bin/env bash

which acpi &> /dev/null || exit 0

PERCENT=$(acpi -b | sed -E 's/.+, ([0-9]+)%.*/\1/')
STATUS=$(acpi -b | sed -E 's/.+: (\w+),.+/\1/')

COLOR="#FFFFFF"
if [ "$PERCENT" -lt 5 ]; then
  [ "$STATUS" != Charging ] && notify-send "  Low Battery!" "$PERCENT% Battery remaining"
  COLOR="#FF0000"
fi

if [ "$STATUS" = Charging ]; then ICON=""
elif [ "$PERCENT" -lt 10 ]; then ICON=""
elif [ "$PERCENT" -lt 20 ]; then ICON=""
elif [ "$PERCENT" -lt 30 ]; then ICON=""
elif [ "$PERCENT" -lt 40 ]; then ICON=""
elif [ "$PERCENT" -lt 50 ]; then ICON=""
elif [ "$PERCENT" -lt 60 ]; then ICON=""
elif [ "$PERCENT" -lt 70 ]; then ICON=""
elif [ "$PERCENT" -lt 80 ]; then ICON=""
elif [ "$PERCENT" -lt 90 ]; then ICON=""
else ICON=""
fi

printf "​"

echo "$ICON"
echo "$ICON"
echo "$COLOR"
