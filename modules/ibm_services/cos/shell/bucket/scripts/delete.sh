#!/bin/bash


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
ibmcloud cos config regions-endpoint --url $REGIONS_ENDPOINT
output=$(ibmcloud cos delete-bucket --bucket $NAME \
	 --region $REGION \
	 --force --json)
ibmcloud logout

echo $output
