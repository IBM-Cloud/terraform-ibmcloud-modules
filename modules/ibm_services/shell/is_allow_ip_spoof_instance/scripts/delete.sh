#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740521
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
IN=$(cat)
echo "stdin: $IN"
instance_id=$(echo $IN | jq -r .id)
echo $instance_id

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP
ibmcloud is target --gen 2
readout=$(ibmcloud is instance-delete $instance_id -f)
ibmcloud logout

echo $readout
