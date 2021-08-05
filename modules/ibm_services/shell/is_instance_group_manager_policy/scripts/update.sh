#!/bin/bash


set -ex
IN=$(cat)
is_igmp_id=$(echo $IN | jq -r .id)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
updated=$(ibmcloud is igmpu $IG_ID $IGM_ID $is_igmp_id \
          --metric-type $METRIC_TYPE \
          --metric-value $METRIC_VALUE \
          --output json)
ibmcloud logout
echo $updated
