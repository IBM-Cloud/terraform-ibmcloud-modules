#!/bin/bash


set -ex
echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
is_ig=$(ibmcloud is igc $IG_NAME \
        --instance-template $IT_ID \
        --subnet-ids $SUBNET_ID \
        --membership-count $MEMBERSHIP_COUNT \
        --resource-group-id  $RESOURCE_GROUP_ID \
         --output json)
ibmcloud logout
echo $is_ig
