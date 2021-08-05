#!/bin/bash


set -ex
IN=$(cat)
is_ig_id=$(echo $IN | jq -r .id)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION
ibmcloud is target --gen 2
ibmcloud is igd -f $is_ig_id
ibmcloud logout
