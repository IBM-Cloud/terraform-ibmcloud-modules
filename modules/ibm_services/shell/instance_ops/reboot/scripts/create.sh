#!/bin/bash


set -ex
echo "rebooting..."
IN=$(cat)
echo "stdin: ${IN}"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
output=$(ibmcloud is instance-reboot $INSTANCE_ID --no-wait --force --output json)
ibmcloud logout

echo $output
