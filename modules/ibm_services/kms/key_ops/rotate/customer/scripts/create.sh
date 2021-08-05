#!/bin/bash


set -ex
export KP_PRIVATE_ADDR=$KMS_ENDPOINT

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud kp key rotate $KMS_KEY_ID \
	 --instance-id $KMS_INSTANCE_GUID \
	 --key-material $KEY_MATERIAL)
ibmcloud logout

echo $(jq -n --arg rotate_status "$output" '{status: $rotate_status}')
