#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-86123-1617860268
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud is share-create \
	 --name $SHARE_NAME \
	 --zone $ZONE \
	 --profile $SHARE_PROFILE \
	 --size $SHARE_SIZE \
	 --resource-group-id $RESOURCE_GROUP_ID \
	 --output JSON)
ibmcloud logout

echo $output
