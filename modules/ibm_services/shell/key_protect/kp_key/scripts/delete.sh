#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"
key_id=$(echo $IN | jq -r .id)
echo $key_id

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud kp region-set staging
readout=$(ibmcloud kp key delete $key_id \
	  -i $KP_INSTANCE_ID \
	  -f)
ibmcloud logout

echo $readout
