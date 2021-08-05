#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"
dhg_id=$(echo $IN |jq -r .id)

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output==$(ibmcloud is dedicated-host-group-update $dhg_id --name $NAME --output JSON)
ibmcloud logout

echo $output
