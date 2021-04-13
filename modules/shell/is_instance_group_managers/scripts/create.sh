#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740543
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
is_igm=$(ibmcloud is igmc $IG_ID \
         --min-members $MIN_MEMBERS \
         --max-members $MAX_MEMBERS \
         --aggregation-window $AGGREGATION_WINDOW \
         --cooldown $COOLDOWN \
         --output json)
ibmcloud logout
echo $is_igm
