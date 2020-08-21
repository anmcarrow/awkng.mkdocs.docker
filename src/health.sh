#!/bin/bash

PING_URI="http://localhost:${HEALTHCHECK_PORT:-8000}/"
PING_RESPONSE="$(wget -O- --timeout=10 -q $PING_URL)"

if (echo -e "$PING_RESPONSE" | grep 'MkDocs version' > /dev/null 2>&1); then
  echo "OK"
  exit 0
else
  echo "MkDocs health endpoint $PING_URL is not healthy. Details: $PING_RESPONSE"
  exit 1
fi

