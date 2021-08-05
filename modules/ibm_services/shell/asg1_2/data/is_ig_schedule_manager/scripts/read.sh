#!/bin/bash


set -ex
IN=$(cat)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP -q
is_ig_scheduled_manager=$(ibmcloud is igm $IG_ID $IGM_ID --output json)
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
echo $is_ig_scheduled_manager
