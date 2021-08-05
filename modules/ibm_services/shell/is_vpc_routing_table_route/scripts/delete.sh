#!/bin/bash


set -ex
IN=$(cat)
is_vpc_rtbl_rt_id=$(echo $IN | jq -r .id)
ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP
ibmcloud is target --gen 2
ibmcloud is vpc-rtbl-rtd -f $VPC_ID $VPC_RTBL_ID $is_vpc_rtbl_rt_id
ibmcloud logout

# root@8d3d894bd869:/system-tf-base/modules/shell/is_vpc_routing_table_route# ic is vpc-rtbl-rtd --help
# NAME:
#     vpc-routing-table-route-delete - Delete a VPC route
#
# USAGE:
#     ibmcloud is vpc-routing-table-route-delete VPC ROUTING_TABLE ROUTE [-f, --force] [-q, --quiet]
#     VPC:           ID of the VPC.
#     ROUTING_TABLE: ID of the VPC routing table.
#     ROUTE:         ID of the VPC route.
#
# OPTIONS:
#     --force, -f  Force the operation without confirmation
#     -q, --quiet  Suppress verbose output
#
# root@8d3d894bd869:/system-tf-base/modules/shell/is_vpc_routing_table_route#
#
