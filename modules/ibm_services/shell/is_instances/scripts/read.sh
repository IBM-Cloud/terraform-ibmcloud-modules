#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"
instance_id=$(echo $IN | jq -r .id)
echo $instance_id

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
instance=$(ibmcloud is instance $instance_id --output json)
ibmcloud logout

echo $instance
