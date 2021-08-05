#!/bin/bash


set -ex
source ${SCRIPTS_PATH}/functions
IN=$(cat)
echo "stdin: $IN"

ifv="ibmcloud is image-create $IFV_NAME --source-volume $SOURCE_VOLUME_ID"
if [ -n "$ENCRYPTION_KEY" ]; then
	ifv="$ifv --encryption-key-volume $ENCRYPTION_KEY"
fi
ifv="$ifv --output JSON"

cmd="ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q"
retry 5 10 $cmd
output=$($ifv)
echo $output
