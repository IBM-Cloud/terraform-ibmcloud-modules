#!/bin/bash


set -ex
echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"
echo "it name: $IT_NAME, vpc id: $VPC_ID, zone_name: $ZONE_NAME, user_dat: $USER_DATA"

if [ -z "$USER_DATA" ]; then
        echo "no user data"
        TARGET_USER_DATA='""'
else
        echo "it must be the absolute path"
        TARGET_USER_DATA="@$USER_DATA"
fi

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud target -g Default
ibmcloud is target --gen 2
is_it=$(ibmcloud is itc $IT_NAME $VPC_ID $ZONE_NAME $PROFILE_NAME $SUBNET_ID \
        --image-id $IMAGE_ID \
        --key-ids $KEYS \
        --user-data $TARGET_USER_DATA \
        --resource-group-id  $RESOURCE_GROUP_ID \
         --output json)
ibmcloud logout
echo $is_it
