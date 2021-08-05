#!/bin/bash


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
