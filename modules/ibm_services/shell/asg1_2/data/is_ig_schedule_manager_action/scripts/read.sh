#!/bin/bash


set -ex
IN=$(cat)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP -q
is_ig_scheduled_manager_action=$(ibmcloud is igma $IG_ID $IGM_ID $IGMA_ID --output json)
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
echo $is_ig_scheduled_manager_action
