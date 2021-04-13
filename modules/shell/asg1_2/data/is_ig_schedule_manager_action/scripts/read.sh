#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-85275-1615444556
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
IN=$(cat)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP -q
is_ig_scheduled_manager_action=$(ibmcloud is igma $IG_ID $IGM_ID $IGMA_ID --output json)
ret=$?
if [ $ret -ne 0 ]; then
        exit 1
fi
echo $is_ig_scheduled_manager_action
