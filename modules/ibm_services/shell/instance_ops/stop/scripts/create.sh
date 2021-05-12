#!/bin/bash


set -ex
echo "stopping..."
IN=$(cat)
echo "stdin: ${IN}"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
output=$(echo y|ibmcloud is instance-stop $INSTANCE_ID --output json)
ibmcloud logout

echo $output
