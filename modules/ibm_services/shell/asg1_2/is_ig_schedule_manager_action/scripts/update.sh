#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-85275-1615444571
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"
echo "ig id: $IG_ID"
echo "igm id: $IGM_ID"
echo "igma name: $IGMA_NAME"
is_ig_schedule_manager_action_id=$(echo $IN | jq -r .id)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP -q
ARGUMENTS="${IG_ID} ${IGM_ID} ${is_ig_schedule_manager_action_id}"

if [ -n "$IGMA_NAME" ]; then
	ARGUMENTS="$ARGUMENTS --name $IGMA_NAME"
fi
ARGUMENTS="$ARGUMENTS --output json"

is_ig_scheduled_manager_action=$(echo $ARGUMENTS | xargs ibmcloud is igmau)
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
echo $is_ig_scheduled_manager_action
