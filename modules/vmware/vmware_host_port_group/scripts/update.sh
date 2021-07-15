#!/bin/bash
export GOVC_URL=${GOVC_URL}
export GOVC_USERNAME=${GOVC_USERNAME}
export GOVC_PASSWORD=${GOVC_PASSWORD}
export GOVC_INSECURE=${GOVC_INSECURE}

function retry {
  local n=1
  local max=10
  local delay=30
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
retry govc about

set -ex
IN=$(cat)
vmware_host_port_group=$(govc host.portgroup.info -json | jq -r '.Portgroup[] | select(.Spec.Name=="'"${HOST_PORT_GROUP}"'")')
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
echo $vmware_host_port_group
