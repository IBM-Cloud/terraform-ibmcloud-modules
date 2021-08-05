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
IN=$(cat)
is_bm_id=$(echo $IN | jq -r .id)
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
is_bm_exist=$(ibmcloud is bms | grep $is_bm_id | wc -l)
while [[ $is_bm_exist == *"1"* ]]
do
  ibmcloud is bmd -f $is_bm_id
  sleep 30s
  is_bm_exist=$(ibmcloud is bms | grep $is_bm_id | wc -l)
done
sleep 60m
