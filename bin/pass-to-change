#!/usr/bin/env bash

DATE="$@"
TEMP=$(mktemp -d)

pass git ls-files | sort | uniq | grep '.gpg$' > "$TEMP/all"
pass git log --since "$DATE" --name-only --pretty=format: | sort | uniq > "$TEMP/recent"
comm -23 "$TEMP/all" "$TEMP/recent"

rm -rf "$TEMP"
