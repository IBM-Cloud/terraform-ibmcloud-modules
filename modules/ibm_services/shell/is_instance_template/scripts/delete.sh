#!/bin/bash


set -ex
IN=$(cat)
is_it_id=$(echo $IN | jq -r .id)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud is target --gen 2
ibmcloud is itd -f $is_it_id
ibmcloud logout
