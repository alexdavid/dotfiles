#!/usr/bin/env bash

which light &> /dev/null || exit 0

BRIGHTNESS=$(light -G  | awk '{ print int($1) }')
[ -n "$BRIGHTNESS" ] && echo " $BRIGHTNESS%"
