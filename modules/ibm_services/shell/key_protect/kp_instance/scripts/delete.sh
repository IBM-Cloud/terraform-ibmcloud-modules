#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
readout=$(ibmcloud resource service-instance-delete $NAME -f)
ibmcloud logout

echo $readout
