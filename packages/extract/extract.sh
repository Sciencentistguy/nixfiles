#!/usr/bin/env bash

# A script to extract many kinds of archive

# Code licence: MPL-2.0 (https://www.mozilla.org/en-US/MPL/2.0/)

extract() {
    local file=$1

    if [ ! -f "$file" ]; then
        echo "'$file' is not a valid file" >&2
        return 1
    fi

    case $file in
    *.tar | *.tar.* | *.tgz | *.tbz | *.tbz2 | *.txz | *.tlz | *.tzst | *.taz) tar xvf "$file" ;;
    *.bz2) bunzip2 "$file" ;;
    *.gz) gunzip "$file" ;;
    *.xz) unxz "$file" ;;
    *.zst) unzstd "$file" ;;
    *.lz) lzip -d "$file" ;;
    *.Z) uncompress "$file" ;;
    *.rar) unrar x "$file" ;;
    *.zip) unzip "$file" ;;
    *.7z) 7z x "$file" ;;
    *)
        echo "'$file' cannot be extracted via extract.sh" >&2
        return 1
        ;;
    esac
}

if [ $# -eq 0 ]; then
    echo "usage: ${0##*/} FILE..." >&2
    exit 2
fi

status=0
for file in "$@"; do
    extract "$file" || status=1
done
exit $status
