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
#is_baremetal_server_network_interface_floating_ips=$(ibmcloud is bm-nic-ips $BM_SERVER $BM_SERVER_NETWORK_INTERFACE --output json)
is_baremetal_server_network_interface_floating_ips=$(ibmcloud is bm-nic-ips $BM_SERVER $BM_SERVER_NETWORK_INTERFACE --output json | jq '{count : . |length, nic_fips: [{id: .[] | .id, name: .[]|.name}]}')
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
ibmcloud logout
sleep 3s
echo $is_baremetal_server_network_interface_floating_ips
