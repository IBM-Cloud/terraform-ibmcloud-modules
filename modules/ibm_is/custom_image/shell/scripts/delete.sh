#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"
image_id=$(echo $IN | jq -r .id)
echo $image_id

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
ibmcloud is target --gen 2
output=$(ibmcloud is image-delete $image_id --force)
ibmcloud logout

echo $output
