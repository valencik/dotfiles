#!/usr/bin/env bash

reddit () {
  curl --silent --url "https://www.reddit.com/r/$1/.json" \
  --user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A" |
  jq --raw-output '.data.children[]|.data.url'
}

filename="$1"
output="links-$(date +%s).txt"

while read -r line
do
    subreddit="$line"
    echo "fetching r/$subreddit..."
    reddit "$subreddit" >> "$output"
    echo "sleeping..."
    sleep 2
done < "$filename"

echo "fin"


