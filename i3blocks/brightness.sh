#!/usr/bin/env bash

BRIGHTNESS=$(light -G  | awk '{ print int($1) }')
[ -n "$BRIGHTNESS" ] && echo "$BRIGHTNESS%"
