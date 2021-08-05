#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud is dedicated-host-create --name $NAME \
	 --host-group-id $HOST_GROUP_ID \
	 --profile $PROFILE \
	 --enabled $ENABLED \
	 --resource-group-id $RESOURCE_GROUP_ID \
	 --output JSON)
ibmcloud logout

echo $output
