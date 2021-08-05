#!/bin/bash


set -ex
source ${SCRIPTS_PATH}/functions
IN=$(cat)
echo "stdin: $IN"

cmd="ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q"
retry 5 10 $cmd
output=$(ibmcloud is snapshot-create \
	 --name $SNAPSHOT_NAME \
	 --volume $VOLUME_ID \
	 --resource-group-id $RESOURCE_GROUP_ID \
	 --output JSON)
echo $output
