#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740436
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
IN=$(cat)
echo "stdin: $IN"
image_id=$(echo $IN | jq -r .id)
echo $image_id

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
ibmcloud is target --gen 2
output=$(ibmcloud is image $image_id --output json)
ibmcloud logout

echo $output
