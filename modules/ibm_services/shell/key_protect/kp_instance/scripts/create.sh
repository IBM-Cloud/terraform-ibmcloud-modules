#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
output=$(ibmcloud resource service-instance-create $NAME $SERVICE $PLAN $LOCATION -q)
ibmcloud logout

echo $output
