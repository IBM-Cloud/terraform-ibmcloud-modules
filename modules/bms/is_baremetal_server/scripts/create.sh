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

## How to create a bms
## ic is bmc
## --name syyang-bm-0
## --zone us-south-2
## --profile bx2d-metaldev8-160x768
## --image r134-31c8ca90-2623-48d7-8cf7-737be6fc4c3e
## --keys r134-f546c083-391a-4b21-8990-ac89a4020db8
## --user-data @firstboot_esxi.sh
## --pnic-name syyang-bm-0-pnic-0
## --pnic-subnet 2209-65a196c8-1d70-495b-862d-35fccea2c0f0
## --pnic-allowed-vlans 100,101,102,103
## --pnic-ein true
## --pnic-ais true
##     IBM_REGION                   = var.ibm_region
##     RESOURCE_GROUP               = var.resource_group
##     BM_SERVER_NAME               = var.bm_server_name
##     BM_SERVER_ZONE               = var.bm_server_zone
##     BM_SERVER_PROFILE            = var.bm_server_profile
##     BM_SERVER_IMAGE              = var.bm_server_image
##     BM_SERVER_KEYS               = var.bm_server_keys
##     BM_SERVER_USERDATA           = var.bm_server_userdata
##     BM_SERVER_PNIC_NAME          = var.bm_server_pnic_name
##     BM_SERVER_PNIC_SUBNET        = var.bm_server_pnic_subnet
##     BM_SERVER_PNIC_ALLOWED_VLANS = var.bm_server_pnic_allowed_vlans
##     BM_SERVER_PNIC_EIN           = var.bm_server_ein
##     BM_SERVER_PNIC_AIS           = var.bm_server_ais


retry ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP -q
set -ex
ARGUMENTS=""

if [ -n "$BM_SERVER_NAME" ]; then
	ARGUMENTS="$ARGUMENTS --name $BM_SERVER_NAME"
fi
if [ -n "$BM_SERVER_ZONE" ]; then
	ARGUMENTS="$ARGUMENTS --zone $BM_SERVER_ZONE"
fi
if [ -n "$BM_SERVER_PROFILE" ]; then
	ARGUMENTS="$ARGUMENTS --profile $BM_SERVER_PROFILE"
fi
if [ -n "$BM_SERVER_IMAGE" ]; then
	ARGUMENTS="$ARGUMENTS --image $BM_SERVER_IMAGE"
fi
if [ -n "$BM_SERVER_KEYS" ]; then
	ARGUMENTS="$ARGUMENTS --keys $BM_SERVER_KEYS"
fi
if [ -n "$BM_SERVER_USERDATA" ]; then
	ARGUMENTS="$ARGUMENTS --user-data @$BM_SERVER_USERDATA"
fi
if [ -n "$BM_SERVER_PNIC_NAME" ]; then
	ARGUMENTS="$ARGUMENTS --pnic-name $BM_SERVER_PNIC_NAME"
fi
if [ -n "$BM_SERVER_PNIC_SUBNET" ]; then
	ARGUMENTS="$ARGUMENTS --pnic-subnet $BM_SERVER_PNIC_SUBNET"
fi
if [ -n "$BM_SERVER_PNIC_ALLOWED_VLANS" ]; then
	ARGUMENTS="$ARGUMENTS --pnic-allowed-vlans $BM_SERVER_PNIC_ALLOWED_VLANS"
fi
if [ -n "$BM_SERVER_PNIC_EIN" ]; then
	ARGUMENTS="$ARGUMENTS --pnic-ein $BM_SERVER_PNIC_EIN"
fi
if [ -n "$BM_SERVER_PNIC_AIS" ]; then
	ARGUMENTS="$ARGUMENTS --pnic-ais $BM_SERVER_PNIC_AIS"
fi
ARGUMENTS="$ARGUMENTS --output json"

is_bm=$(echo $ARGUMENTS | xargs ibmcloud is bmc)
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
is_bm_status=$(echo $is_bm | jq -r .status)
is_bm_id=$(echo $is_bm | jq -r .id)
while [ $is_bm_status = "failed" ] || [ $is_bm_status = "pending" ]
do
  if [ $is_bm_status = "pending" ]; then
    is_bm=$(ibmcloud is bm $is_bm_id --output json)
  else
    ibmcloud is bmd -f $is_bm_id
    sleep 10s
    is_bm=$(echo $ARGUMENTS | xargs ibmcloud is bmc)
  fi
  is_bm_status=$(echo $is_bm | jq -r .status)
  is_bm_id=$(echo $is_bm | jq -r .id)
  sleep 30s
done
while [ $is_bm_status = "stopped" ] || [ $is_bm_status = "starting" ]
do
  sleep 30s
  ibmcloud is bm $is_bm_id
  is_bm=$(ibmcloud is bm $is_bm_id --output json)
  is_bm_status=$(echo $is_bm | jq -r .status)
  is_bm_id=$(echo $is_bm | jq -r .id)
done
echo $is_bm
