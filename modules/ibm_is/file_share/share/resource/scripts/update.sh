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
share_id=$(echo $IN |jq -r .id)

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud is share-update $share_id --name $NAME --output JSON)
ibmcloud logout

echo $output
