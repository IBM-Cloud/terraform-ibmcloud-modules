#!/bin/bash


set -ex

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $REGION -g $RESOURCE_GROUP_ID -q
output=$(ibmcloud is share $SHARE_ID --output JSON)
ibmcloud logout

echo $output
