#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740468
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


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
