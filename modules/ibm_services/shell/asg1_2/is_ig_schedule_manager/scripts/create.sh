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

echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"
echo "ig id: $IG_ID"
echo "igm name: $IGM_NAME"

retry ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP -q
set -ex
ARGUMENTS="${IG_ID}"

if [ -n "$IGM_NAME" ]; then
	ARGUMENTS="$ARGUMENTS --manager-type scheduled --name $IGM_NAME"
fi
ARGUMENTS="$ARGUMENTS --output json"

is_ig_scheduled_manager=$(echo $ARGUMENTS | xargs ibmcloud is igmc)
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
echo $is_ig_scheduled_manager
