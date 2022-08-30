#!/bin/bash


if [ "$(which dig | wc -l)" -ne 1 ]; then
    echo "Could not find dig in path, bailing (PATH: ${PATH})"
    exit 1
fi

if [ "$(which date | wc -l)" -ne 1 ]; then
    echo "Could not find date in path, bailing (PATH: ${PATH})"
    exit 1
fi

if [ -z "$1" ]; then
    TARGET=localhost
    #>&2 echo "Using localhost"
else
    TARGET="${1}"
    #>&2 echo "Checking ${TARGET}"
fi

CACHE_SIZE="$(dig +short chaos txt cachesize.bind "@${TARGET}" 2>/dev/null || echo  '"error"')"
INSERTIONS="$(dig +short chaos txt insertions.bind "@${TARGET}" 2>/dev/null || echo  '"error"')"
EVICTIONS="$(dig +short chaos txt evictions.bind "@${TARGET}" 2>/dev/null || echo '"error"')"
MISSES="$(dig +short chaos txt misses.bind "@${TARGET}" 2>/dev/null || echo  '"error"')"
HITS="$(dig +short chaos txt hits.bind "@${TARGET}" 2>/dev/null || echo  '"error"')"
AUTH="$(dig +short chaos txt auth.bind "@${TARGET}" 2>/dev/null || echo  '"error"')"
SERVERS="$(dig +short chaos txt servers.bind "@${TARGET}" 2>/dev/null | sed -E 's/" "/","/' || echo  '"error"')"

# tries a few different timestamp options
TIMESTAMP="$(date --rfc-3339=seconds 2>/dev/null || date -Iseconds 2>/dev/null || date)"

echo -n "{"
echo -n "\"timestamp\":\"${TIMESTAMP}\","
echo -n "\"cache\":${CACHE_SIZE},"
echo -n "\"evictions\":${EVICTIONS},"
echo -n "\"insertions\":${INSERTIONS},"
echo -n "\"hits\":${HITS},"
echo -n "\"misses\":${MISSES},"
echo -n "\"auth:\":${AUTH},"
echo "\"servers\":[${SERVERS}]}"
