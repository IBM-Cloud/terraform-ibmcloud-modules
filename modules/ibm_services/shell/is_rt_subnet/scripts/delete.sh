#!/bin/bash


set -ex
IN=$(cat)
is_rt_subnet_id=$(echo $IN | jq -r .id)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP
ibmcloud is target --gen 2
ibmcloud is subnetd -f $is_rt_subnet_id
ibmcloud logout

# root@1db69b00ef96:/system-tf-base# ic is subnetd --help
# NAME:
#     subnet-delete - Delete a subnet
#
# USAGE:
#     ibmcloud is subnet-delete SUBNET [-f, --force] [-q, --quiet]
#     SUBNET: ID of the subnet.
#
# OPTIONS:
#     --force, -f  Force the operation without confirmation
#     -q, --quiet  Suppress verbose output
#
# root@1db69b00ef96:/system-tf-base#
#
