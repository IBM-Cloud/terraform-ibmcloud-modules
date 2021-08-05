#!/bin/bash


set -ex
IN=$(cat)
is_igmp_id=$(echo $IN | jq -r .id)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud is target --gen 2
ibmcloud is igmpd -f $IG_ID $IGM_ID $is_igmp_id
ibmcloud logout
