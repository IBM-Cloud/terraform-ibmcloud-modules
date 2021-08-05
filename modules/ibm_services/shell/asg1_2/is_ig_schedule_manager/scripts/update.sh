#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-85275-1615444571
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.

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
echo "ig id: $IG_ID"
echo "igm name: $IGM_NAME"
is_ig_schedule_manager_id=$(echo $IN | jq -r .id)
ARGUMENTS="${IG_ID} ${is_ig_schedule_manager_id}"

if [ -n "$IGM_NAME" ]; then
	ARGUMENTS="$ARGUMENTS --name $IGM_NAME"
fi
ARGUMENTS="$ARGUMENTS --output json"

is_ig_scheduled_manager=$(echo $ARGUMENTS | xargs ibmcloud is igmu)
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
echo $is_ig_scheduled_manager
