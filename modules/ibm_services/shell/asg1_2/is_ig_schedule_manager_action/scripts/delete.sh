#!/bin/bash


set -ex
IN=$(cat)
is_ig_schedule_manager_action_id=$(echo $IN | jq -r .id)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP -q
ibmcloud is igmad $IG_ID $IGM_ID $is_ig_schedule_manager_action_id -f
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
