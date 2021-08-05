#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-88229-1619511386
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


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
