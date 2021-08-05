#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740441
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
IN=$(cat)
echo "stdin: $IN"
dh_id=$(echo $IN |jq -r .id)

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output==$(ibmcloud is dedicated-host-update $dh_id --enabled $ENABLED --output JSON)
ibmcloud logout

echo $output
