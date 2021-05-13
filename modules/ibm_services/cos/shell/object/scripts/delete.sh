#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud cos delete-object --bucket $BUCKET_NAME \
	 --key $KEY \
	 --region $REGION \
	 --force --json)
ibmcloud logout

echo $output
