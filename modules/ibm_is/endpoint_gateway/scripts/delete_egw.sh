#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"
vpe_id=$(echo $IN |jq -r .id)

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output==$(ibmcloud is endpoint-gateway-delete $vpe_id --force --output JSON)
ibmcloud logout

echo $output

