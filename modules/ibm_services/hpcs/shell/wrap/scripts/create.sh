#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740487
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP_ID -q
passphrase_base64=$(echo -n "$PASSPHRASE" |base64)
output=$(ibmcloud kp key wrap $KMS_KEY_ID \
	 --plaintext $passphrase_base64 \
	 --instance-id $KMS_INSTANCE_GUID \
	 --output json)
ibmcloud logout

echo $output
