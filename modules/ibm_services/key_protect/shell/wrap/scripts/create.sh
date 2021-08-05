#!/bin/bash


set -ex

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP_ID -q
ibmcloud kp region-set staging
passphrase_base64=$(echo -n "$PASSPHRASE" |base64)
output=$(ibmcloud kp key wrap $KP_KEY_ID \
	 --plaintext $passphrase_base64 \
	 --instance-id $KP_INSTANCE_ID \
	 --output json)
ibmcloud logout

echo $output
