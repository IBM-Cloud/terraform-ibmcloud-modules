#!/bin/bash


set -ex
echo "reading..."
IN=$(cat)
echo "stdin: ${IN}"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP
ibmcloud is target --gen 2
readout=$(ibmcloud is instance $INSTANCE_ID --output json)
ibmcloud logout

echo $readout
