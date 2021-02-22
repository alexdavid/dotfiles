#!/usr/bin/env bash

if TW=$(timew); then
  echo " $(head -n1 <<< "$TW" | awk '{ print $2 }')" "$(tail -n1 <<< "$TW" | awk '{ print $2 }')"
fi
