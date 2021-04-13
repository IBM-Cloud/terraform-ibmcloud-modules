#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740533
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
is_igmp=$(ibmcloud is igmpc $IG_ID $IGM_ID \
         --metric-type $METRIC_TYPE \
         --metric-value $METRIC_VALUE \
         --output json)
ibmcloud logout
echo $is_igmp
