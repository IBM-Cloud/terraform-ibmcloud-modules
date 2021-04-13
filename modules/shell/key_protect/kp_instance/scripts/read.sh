#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740583
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
IN=$(cat)
echo "stdin: $IN"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -q
ibmcloud target -g Default
readout=$(ibmcloud resource service-instance $NAME --output json|jq .[0])
ibmcloud logout

echo $readout
