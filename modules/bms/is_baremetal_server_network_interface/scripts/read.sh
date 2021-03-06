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
sleep 3s

set -ex
IN=$(cat)
is_bm_nic_id=$(echo $IN | jq -r .id)
is_baremetal_server_network_interface=$(ibmcloud is bm-nic $BM_SERVER $is_bm_nic_id --output json)
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
ibmcloud logout
sleep 3s
echo $is_baremetal_server_network_interface
