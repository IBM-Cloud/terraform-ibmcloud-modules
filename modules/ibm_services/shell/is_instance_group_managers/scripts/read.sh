#!/bin/bash


set -ex
IN=$(cat)
is_igm_id=$(echo $IN | jq -r .id)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
readout=$(ibmcloud is igm $IG_ID $is_igm_id --output json)
ibmcloud logout
echo $readout
