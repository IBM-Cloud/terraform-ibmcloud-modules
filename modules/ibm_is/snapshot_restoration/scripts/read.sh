#!/bin/bash


set -ex
source ${SCRIPTS_PATH}/functions
IN=$(cat)
echo "stdin: $IN"
instance_id=$(echo $IN |jq -r .id)

cmd="ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q"
retry 5 10 $cmd
output=$(ibmcloud is instance $instance_id --output JSON)
echo $output
