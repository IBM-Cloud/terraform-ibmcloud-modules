#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740470
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
ibmcloud cos config regions-endpoint --url $REGIONS_ENDPOINT
output=$(ibmcloud cos head-bucket --bucket $NAME \
	 --region $REGION \
         --json)
ibmcloud logout

echo $output
