#!/bin/bash
# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740578
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


set -ex
echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"
echo "vpc rtbl route name: $VPC_RTBL_RT_NAME"
echo "vpc id: $VPC_ID"
echo "vpc rtbl id: $VPC_RTBL_ID"
echo "zone name: $ZONE_NAME"
echo "destination: $DESTINATION"
echo "next_hop: $NEXT_HOP"
echo "action: $ACTION"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP
ibmcloud is target --gen 2

if [ "$ACTION" = "deliver" ]; then
is_vpc_rtbl_rt=$(ibmcloud is vpc-rtbl-rtc $VPC_ID $VPC_RTBL_ID \
          --name $VPC_RTBL_RT_NAME \
          --zone $ZONE_NAME \
          --destination $DESTINATION \
          --next-hop $NEXT_HOP \
          --action $ACTION \
          --output json)
else
is_vpc_rtbl_rt=$(ibmcloud is vpc-rtbl-rtc $VPC_ID $VPC_RTBL_ID \
          --name $VPC_RTBL_RT_NAME \
          --zone $ZONE_NAME \
          --destination $DESTINATION \
          --action $ACTION \
          --output json)
fi

ibmcloud logout
echo $is_vpc_rtbl_rt


# root@8d3d894bd869:/system-tf-base# ic is vpc-rtbl-rtc --help
# NAME:
#     vpc-routing-table-route-create - Create a VPC route
#
# USAGE:
#     ibmcloud is vpc-routing-table-route-create VPC ROUTING_TABLE --zone ZONE_NAME --destination DESTINATION_CIDR --next-hop NEXT_HOP [--action delegate | deliver | drop] [--name NAME] [--output JSON] [-q, --quiet]
#     VPC:           ID of the VPC.
#     ROUTING_TABLE: ID of the VPC routing table.
#
# EXAMPLE:
#     ibmcloud is vpc-routing-table-route-create 72b27b5c-f4b0-48bb-b954-5becc7c1dcb3 72b27b5c-f4b0-48bb-b954-5becc7c1d456 --name my-vpc-route --action deliver --zone us-south-1 --destination  10.2.2.0/24 --next-hop 10.0.0.2 --output JSON
#     ibmcloud is vpc-routing-table-route-create 72b27b5c-f4b0-48bb-b954-5becc7c1dcb3 72b27b5c-f4b0-48bb-b954-5becc7c1d456 --name my-vpc-route --action delegate --zone us-south-1 --destination  10.2.2.0/24 --output JSON
#     ibmcloud is vpc-routing-table-route-create 72b27b5c-f4b0-48bb-b954-5becc7c1dcb3 72b27b5c-f4b0-48bb-b954-5becc7c1d456 --name my-vpc-route --action drop --zone us-south-1 --destination  10.2.2.0/24 --output JSON
#
# OPTIONS:
#     --zone value         Name of the zone
#     --action value       The action to perform with a packet matching the route. Enumeration type: delegate, deliver, drop.
#     --destination value  The destination CIDR of the route. At most two routes per zone in a table can have the same destination, and only if both routes have an action of deliver.
#     --next-hop value     If the action is 'deliver', the IP address or VPN connection ID of the next hop to which to route packets
#     --name value         Name of the VPC routing table.
#     --output value       Specify output format, only JSON is supported now. Enumeration type: JSON.
#     -q, --quiet          Suppress verbose output
#
# root@8d3d894bd869:/system-tf-base#
