#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud cos head-object --bucket $BUCKET_NAME \
	 --key $KEY \
	 --region $REGION \
         --json)
ibmcloud logout

echo $output
