#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -q
ibmcloud target -g Default
readout=$(ibmcloud resource service-instance $NAME --output json|jq .[0])
ibmcloud logout

echo $readout
