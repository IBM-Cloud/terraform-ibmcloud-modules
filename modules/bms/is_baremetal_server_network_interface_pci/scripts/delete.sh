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


is_bm_id=$BM_SERVER
is_bm=$(ibmcloud is bm $is_bm_id --output json)
is_bm_status=$(echo $is_bm | jq -r .status)
while [ $is_bm_status = "running" ] || [ $is_bm_status = "pending" ]
do
  ibmcloud is bm-stop -f $is_bm_id
  sleep 30s
  is_bm=$(ibmcloud is bm $is_bm_id --output json)
  is_bm_status=$(echo $is_bm | jq -r .status)
  is_bm_id=$(echo $is_bm | jq -r .id)
done

ibmcloud is bm-nicd -f $BM_SERVER $is_bm_nic_id
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi

is_bm_id=$BM_SERVER
is_bm=$(ibmcloud is bm $is_bm_id --output json)
is_bm_status=$(echo $is_bm | jq -r .status)
while [ $is_bm_status = "stopped" ] || [ $is_bm_status = "starting" ]
do
  if [ $is_bm_status = "stopped" ]; then
    ibmcloud is bm-start $is_bm_id
  fi
  sleep 30s
  is_bm=$(ibmcloud is bm $is_bm_id --output json)
  is_bm_status=$(echo $is_bm | jq -r .status)
  is_bm_id=$(echo $is_bm | jq -r .id)
done


ibmcloud logout
