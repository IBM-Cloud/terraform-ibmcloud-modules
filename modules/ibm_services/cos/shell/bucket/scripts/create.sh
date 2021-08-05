#!/bin/bash


set -ex

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID  -q
ibmcloud cos config regions-endpoint --url $REGIONS_ENDPOINT
output=$(ibmcloud cos create-bucket --bucket $NAME \
	 --ibm-service-instance-id $COS_INSTANCE_ID \
	 --class $STORAGE_CLASS \
	 --region $REGION \
         --json)
ibmcloud logout

if [ "$output" = "" ]; then
	echo $(jq -n --arg bn "$NAME" '{bucket_name: $bn}')
else
	echo $output
fi
