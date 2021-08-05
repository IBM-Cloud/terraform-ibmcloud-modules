#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud kp region-set staging
output=$(ibmcloud kp key unwrap $KP_KEY_ID \
	 $CIPHERTEXT \
	 --aad $AAD \
	 -i $KP_INSTANCE_ID \
	 --output json)
ibmcloud logout

echo $output
