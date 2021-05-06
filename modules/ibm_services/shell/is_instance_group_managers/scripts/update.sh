#!/bin/bash


set -ex
IN=$(cat)
is_igm_id=$(echo $IN | jq -r .id)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
updated=$(ibmcloud is igmu $IG_ID $is_igm_id \
          --min-members $MIN_MEMBERS \
          --max-members $MAX_MEMBERS \
          --aggregation-window $AGGREGATION_WINDOW \
          --cooldown $COOLDOWN \
          --output json)
ibmcloud logout
echo $updated
