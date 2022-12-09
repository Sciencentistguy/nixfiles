#!/usr/bin/env bash

# A script to extract many kinds of archive

# Code licence: MPL-2.0 (https://www.mozilla.org/en-US/MPL/2.0/)

if [ -f "$1" ]; then
    case $1 in
    *.tar*) tar xvf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) unrar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.t?z) tar xvf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *) echo "'$1' cannot be extracted via extract.sh" ;;
    esac
else
    echo "'$1' is not a valid file"
fi
