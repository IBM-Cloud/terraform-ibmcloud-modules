#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud is endpoint-gateway-create --vpc-id $VPC_ID \
	 --target $TARGET_PROVIDER \
         --name $NAME \
	 --output JSON)
ibmcloud logout

echo $output
