#!/bin/bash


set -ex
source ${SCRIPTS_PATH}/functions

cmd="ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q"
retry 5 10 $cmd
output=$(ibmcloud is snapshot $SNAPSHOT_ID --output JSON)
echo $output
