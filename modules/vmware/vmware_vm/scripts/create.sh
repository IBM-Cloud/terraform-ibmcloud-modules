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
ARGUMENTS=""

govc import.ova -options="${OPTION_JSON}" -ds=${GOVC_DSTORE} "${OVA_PATH}"
if [ -n "${MAC_ADDR}" ]; then
govc vm.network.change -net.address "${MAC_ADDR}" -net="${PORT_GROUP_NAME}" -vm="${VM_NAME}" ethernet-0
else
govc vm.network.change -net="${PORT_GROUP_NAME}" -vm="${VM_NAME}" ethernet-0
fi
govc vm.power -on "${VM_NAME}"
govc host.autostart.add "${VM_NAME}"
vmware_vm=$(govc vm.info -json "$VM_NAME")
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
echo $vmware_vm
