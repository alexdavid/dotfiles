#!/usr/bin/env bash

BRIGHTNESS=$(xbacklight -get -display "$DISPLAY" | awk '{ print int($1) }')
echo "$BRIGHTNESS%"
