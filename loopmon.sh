#!/bin/bash

MYDIR="$(dirname "$0")"

while true; do
    # shellcheck disable=SC2086
    $MYDIR/dnsmasqmon.sh "$1"
    sleep 300
done