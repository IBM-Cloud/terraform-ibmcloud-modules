#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"
share_id=$(echo $IN |jq -r .id)

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud is share $share_id --output JSON)
ibmcloud logout

echo $output
