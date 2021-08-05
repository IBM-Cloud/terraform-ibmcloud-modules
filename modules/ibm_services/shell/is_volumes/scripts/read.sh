#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740573
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
IN=$(cat)
echo "stdin: $IN"
volume_id=$(echo $IN | jq -r .id)
echo $volume_id

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
readout=$(ibmcloud is volume $volume_id --output json)
ibmcloud logout

echo $readout
