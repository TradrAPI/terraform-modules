#!/bin/bash
# Exit if any of the intermediate steps fail
# set -e

sleep $((RANDOM % 30))

# Extract "uri" and "key" arguments from the input into
# URI and KEY shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "URI=\(.uri) KEY=\(.key) IV=\(.iv)"')"

python3 -m pip install --no-cache-dir --user PyCryptodome  > /dev/null 2>&1
sleep 10
URI_ENCRYPTED=$(python3 encrypt.py $URI $KEY $IV)


# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg uri_encrypted "$URI_ENCRYPTED" '{"uri_encrypted":$uri_encrypted}'