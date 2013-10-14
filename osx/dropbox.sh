#!/bin/bash

for dir in ~/Dropbox/*/
do
    dir=${dir%*/}
    dir="$HOME/Dropbox/${dir##*/}"

    cd "$dir"
    if [ -f .icon ]
    then
      cp .icon Icon
      setfile -a C .
    fi

done
