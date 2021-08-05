#!/bin/bash


set -ex

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
ibmcloud is target --gen 2
output=$(ibmcloud is image-create $IMAGE_NAME \
	 --file $IMAGE_FILE \
	 --os-name $OS_NAME \
	 --encrypted-data-key $ENCRYPTED_DATA_KEY \
	 --encryption-key $ENCRYPTION_KEY \
	 --resource-group-id $RESOURCE_GROUP_ID \
	 --output json)
ibmcloud logout

echo $output
