#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"
instance_id=$(echo $IN | jq -r .id)
echo $instance_id

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
readout=$(ibmcloud is instance-delete $instance_id -f)
ibmcloud logout

echo $readout
