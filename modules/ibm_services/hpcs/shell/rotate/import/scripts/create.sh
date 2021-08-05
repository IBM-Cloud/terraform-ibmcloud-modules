#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740483
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud kp key rotate $KMS_KEY_ID \
	 --instance-id $KMS_INSTANCE_GUID \
	 --key-material $KEY_MATERIAL)
ibmcloud logout

echo $output
