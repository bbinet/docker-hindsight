#!/bin/bash

set -e

base_url="$1"
md5sum="$2"
filter="$3"

mkdir debs
(cd debs;
    wget "${base_url}/md5sums"
    echo "${md5sum}  md5sums" | md5sum --check
    md5sums=$(cat md5sums)
    if ! [ -z "$filter" ]; then
        md5sums=$(cat md5sums | $filter)
    fi
    echo "$md5sums" | while read line
do
        pkg="${line#*  }"
        wget --retry-connrefused "${base_url}/${pkg}"
        echo "${line}" | md5sum --check
    done
    dpkg -i *.deb
)
rm -fr debs
