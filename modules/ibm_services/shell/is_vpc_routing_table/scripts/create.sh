#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740575
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"
echo "vpc id: $VPC_ID"
echo "vpc rtbl name: $VPC_RTBL_NAME"
echo "route direct link ingress: $DIRECT_LINK_VALUE"
echo "route transit gateway ingress: $TRANSIT_GATEWAY_VALUE"
echo "route vpc zone ingress: $VPC_ZONE_VALUE"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP
ibmcloud is target --gen 2
ARGUMENTS="${VPC_ID}"

if [ -n "$VPC_RTBL_NAME" ]; then
	ARGUMENTS="$ARGUMENTS --name $VPC_RTBL_NAME"
fi
if [ -n "$DIRECT_LINK_VALUE" ]; then
	ARGUMENTS="$ARGUMENTS --direct-link $DIRECT_LINK_VALUE"
fi
if [ -n "$TRANSIT_GATEWAY_VALUE" ]; then
	ARGUMENTS="$ARGUMENTS --transit-gateway $TRANSIT_GATEWAY_VALUE"
fi
if [ -n "$VPC_ZONE_VALUE" ]; then
	ARGUMENTS="$ARGUMENTS --vpc-zone $VPC_ZONE_VALUE"
fi

ARGUMENTS="$ARGUMENTS --output json"

is_vpc_rtbl=$(echo $ARGUMENTS | xargs ibmcloud is vpc-rtblc)
ibmcloud logout
echo $is_vpc_rtbl


# root@8d3d894bd869:/system-tf-base# ic is vpc-rtblc --help
# NAME:
#     vpc-routing-table-create - Create a VPC routing table
#
# USAGE:
#     ibmcloud is vpc-routing-table-create VPC [--name NAME] [--output JSON] [-q, --quiet]
#     VPC: ID of the VPC.
#
# EXAMPLE:
#     ibmcloud is vpc-routing-table-create 72b27b5c-f4b0-48bb-b954-5becc7c1dcb3 --name my-vpc-routing-table --output JSON
#
# OPTIONS:
#     --name value    Name of the VPC routing table.
#     --output value  Specify output format, only JSON is supported now. Enumeration type: JSON.
#     -q, --quiet     Suppress verbose output
#
# root@8d3d894bd869:/system-tf-base#
