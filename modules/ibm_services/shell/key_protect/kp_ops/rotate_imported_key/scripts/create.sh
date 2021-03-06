#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud kp region-set staging
output=$(ibmcloud kp key rotate $KP_KEY_ID \
	 -k $PAYLOAD \
	 -i $KP_INSTANCE_ID)
ibmcloud logout

echo $output
