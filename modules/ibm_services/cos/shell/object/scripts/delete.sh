#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740474
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


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
