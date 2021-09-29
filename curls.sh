#! /bin/bash

if [ -z "$1" ]; then
    echo "Usage: curls.sh <filename>"
    echo "  where <filename> is a text file with a URL on each line."
    echo
    echo "  Outputs URLs that don't return a 200 status code."
    exit 1
fi

filename=$1
while read url; do
    if [ -z "$url" ]; then
        continue
    fi
    response=$(curl --write-out '%{http_code}' --silent --output /dev/null $url)
    if [[ "$response" != "200" ]]; then
        echo "$response from $url"
    fi
done < "$filename"

