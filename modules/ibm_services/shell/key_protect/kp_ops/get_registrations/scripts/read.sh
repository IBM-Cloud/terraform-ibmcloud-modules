#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"
key_id=$(echo $IN | jq -r .id)

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud kp region-set staging
readout=output=$(ibmcloud kp registrations -k $KP_KEY_ID -i $KP_INSTANCE_ID --output json)
ibmcloud logout

echo $readout
