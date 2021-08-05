#!/bin/bash


set -ex
IN=$(cat)
is_ig_id=$(echo $IN | jq -r .id)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
updated=$(ibmcloud is igu $is_ig_id --name $IG_NAME \
          --membership-count $MEMBERSHIP_COUNT \
          --subnet-ids $SUBNET_ID \
          --instance-template $IT_ID \
          --output json)
ibmcloud logout
echo $updated
