#!/bin/bash


set -ex
echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
volume=$(ibmcloud is volume-create $VOL_NAME $VOL_PROFILE $ZONE \
	 --capacity          $VOL_SIZE \
         --encryption-key    "$VOL_ENCRYPTION" \
	 --resource-group-id $RESOURCE_GROUP_ID \
	 --output json)
ibmcloud logout

echo $volume
