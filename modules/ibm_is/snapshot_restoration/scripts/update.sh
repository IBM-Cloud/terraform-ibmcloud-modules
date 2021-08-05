#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-88676-1620634890
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
source ${SCRIPTS_PATH}/functions
IN=$(cat)
echo "stdin: $IN"
instance_id=$(echo $IN |jq -r .id)

cmd="ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q"
retry 5 10 $cmd
output=$(ibmcloud is instance-update $instance_id --name $INSTANCE_NAME --output JSON)
echo $output
