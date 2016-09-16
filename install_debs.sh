#!/bin/bash

set -e

base_url="$1"
md5sum="$2"

mkdir debs
(cd debs;
    wget "${base_url}/md5sums"
    echo "${md5sum}  md5sums" | md5sum --check
    cat md5sums | while read line
do
        pkg="${line#*  }"
        wget --retry-connrefused "${base_url}/${pkg}"
        echo "${line}" | md5sum --check
    done
    dpkg -i *.deb
)
rm -fr debs
