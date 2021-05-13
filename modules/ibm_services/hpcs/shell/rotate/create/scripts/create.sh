#!/bin/bash


set -ex

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud kp key rotate $KMS_KEY_ID --instance-id $KMS_INSTANCE_GUID)
ibmcloud logout

echo $output
