#!/bin/bash


set -ex
IN=$(cat)
is_igm_id=$(echo $IN | jq -r .id)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud is target --gen 2
ibmcloud is igmd -f $IG_ID $is_igm_id
ibmcloud logout
