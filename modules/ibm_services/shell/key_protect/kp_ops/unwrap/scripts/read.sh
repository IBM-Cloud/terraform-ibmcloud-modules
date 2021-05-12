#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud kp region-set staging
readout=$(ibmcloud kp key show $KP_KEY_ID -i $KP_INSTANCE_ID --output json)
ibmcloud logout

echo $readout
