#!/usr/bin/env sh

settings="$(dirname "$0")/settings.json"
tempfile="$(mktemp)"

jq --sort-keys . "$settings" > "$tempfile"
mv "$tempfile" "$settings"