#!/bin/sh
echo -e "Content-type: text/plain\r"
echo -e "\r"

if [ "$REQUEST_METHOD" = "GET" ]; then
  days=$(echo "$QUERY_STRING" | sed -n 's/^.*days=\([^&]*\).*$/\1/p')
  action=$(echo "$QUERY_STRING" | sed -n 's/^.*action=\([^&]*\).*$/\1/p')
  /mnt/mmc01/wrk/scripts/cleanup.sh $days $action
fi
