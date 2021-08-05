#!/bin/bash

function retry {
  local n=1
  local max=5
  local delay=1
  while true; do
    "$@" && break || {
      if [[ $n -lt $max ]]; then
        ((n++))
        echo "Command failed. Attempt $n/$max:"
        sleep $delay;
      else
        echo "The command has failed after $n attempts."
        exit 1
      fi
    }
  done
}

retry ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP -q

set -ex
echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"
is_bm_id=$(echo $IN | jq -r .id)

## ibmcloud is bare-metal-server-update
## SERVER
## --name NEW_NAME
## [--enable-secure-boot false | true]
## [--enable-tpm true | false --tpm-mode tpm_2 | tpm_2_with_txt]
## [--output JSON] [-q, --quiet]
ARGUMENTS="$is_bm_id"

if [ -n "$BM_SERVER_NAME" ]; then
	ARGUMENTS="$ARGUMENTS --name $BM_SERVER_NAME"
fi
ARGUMENTS="$ARGUMENTS --output json"

is_bm=$(echo $ARGUMENTS | xargs ibmcloud is bmu)
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
echo $is_bm
