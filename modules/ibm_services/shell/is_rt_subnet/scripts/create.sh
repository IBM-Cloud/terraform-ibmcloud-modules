#!/bin/bash


set -ex
echo "creating..."
IN=$(cat)
echo "stdin: ${IN}"
echo "subnet name: $SUBNET_NAME"
echo "vpc id: $VPC_ID"
echo "zone: $ZONE"
echo "ipv4 cidr block: $IPV4_CIDR_BLOCK"
echo "ipv4 address count: $IPV4_ADDRESS_COUNT"
echo "network acl id: $NETWORK_ACL_ID"
echo "public gateway id: $PUBLIC_GATEWAY_ID"
echo "routing table id: $ROUTING_TABLE_ID"
echo "resource group id: $RESOURCE_GROUP_ID"
echo "resource group name: $RESOURCE_GROUP"

ibmcloud login -a $IBMCLOUD_API_ENDPOINT -r $IBM_REGION -g $RESOURCE_GROUP
ibmcloud is target --gen 2

if [ -n "$IPV4_ADDRESS_COUNT"  ]; then
  if [ -n "$PUBLIC_GATEWAY_ID"  ]; then
    is_rt_subnet=$(ibmcloud is subnetc $SUBNET_NAME $VPC_ID \
          --ipv4-address-count $IPV4_ADDRESS_COUNT \
          --zone $ZONE \
          --routing-table-id $ROUTING_TABLE_ID \
          --resource-group-name $RESOURCE_GROUP \
          --public-gateway-id $PUBLIC_GATEWAY_ID \
          --output json)
  else
    is_rt_subnet=$(ibmcloud is subnetc $SUBNET_NAME $VPC_ID \
          --ipv4-address-count $IPV4_ADDRESS_COUNT \
          --zone $ZONE \
          --routing-table-id $ROUTING_TABLE_ID \
          --resource-group-name $RESOURCE_GROUP \
          --output json)
  fi
else
  if [ -n "$PUBLIC_GATEWAY_ID"  ]; then
    is_rt_subnet=$(ibmcloud is subnetc $SUBNET_NAME $VPC_ID \
          --ipv4-cidr-block $IPV4_CIDR_BLOCK \
          --zone $ZONE \
          --routing-table-id $ROUTING_TABLE_ID \
          --resource-group-name $RESOURCE_GROUP \
          --public-gateway-id $PUBLIC_GATEWAY_ID \
          --output json)
  else
    is_rt_subnet=$(ibmcloud is subnetc $SUBNET_NAME $VPC_ID \
          --ipv4-cidr-block $IPV4_CIDR_BLOCK \
          --zone $ZONE \
          --routing-table-id $ROUTING_TABLE_ID \
          --resource-group-name $RESOURCE_GROUP \
          --output json)
  fi
fi

ibmcloud logout
echo $is_rt_subnet


 # ic is subnetc --help
# NAME:
#     subnet-create - Create a subnet
#
# USAGE:
#     ibmcloud is subnet-create SUBNET_NAME VPC (--ipv4-cidr-block CIDR_BLOCK | (--ipv4-address-count ADDR_COUNT --zone ZONE_NAME)) [--network-acl-id NETWORK_ACL_ID] [--public-gateway-id PUBLIC_GATEWAY_ID] [--routing-table-id ROUTING_TABLE_ID] [--resource-group-id RESOURCE_GROUP_ID | --resource-group-name RESOURCE_GROUP_NAME] [--output JSON] [-q, --quiet]
#     SUBNET_NAME: Name of the subnet.
#     VPC:         ID of the VPC.
#
# EXAMPLE:
#     ibmcloud is subnet-create my-subnet 72b27b5c-f4b0-48bb-b954-5becc7c1dcb3 --ipv4-cidr-block 10.10.10.0/24
#     ibmcloud is subnet-create my-subnet 72b27b5c-f4b0-48bb-b954-5becc7c1dcb3 --ipv4-address-count 256 --zone us-south-2
#     ibmcloud is subnet-create my-subnet 72b27b5c-f4b0-48bb-b954-5becc7c1dcb3 --ipv4-address-count 256 --zone us-south-2 --network-acl-id 8daca77a-4980-4d33-8f3e-7038797be8f9
#     ibmcloud is subnet-create my-subnet 72b27b5c-f4b0-48bb-b954-5becc7c1dcb3 --ipv4-address-count 256 --zone us-south-2 --public-gateway-id 8daca77a-4980-4d33-8f3e-7038797be8f9
#     ibmcloud is subnet-create my-subnet 72b27b5c-f4b0-48bb-b954-5becc7c1dcb3 --ipv4-address-count 256 --zone us-south-2 --public-gateway-id 8daca77a-4980-4d33-8f3e-7038797be8f9 --output JSON
#     ibmcloud is subnet-create my-subnet 72b27b5c-f4b0-48bb-b954-5becc7c1dcb3 --ipv4-address-count 256 --zone us-south-2 --routint-table-id 8daca77a-4980-4d33-8f3e-7038797be8f9
#
# OPTIONS:
#     --ipv4-cidr-block value      the IPv4 range of the subnet. This option is mutually exclusive with --ipv4-address-count
#     --ipv4-address-count value   The total number of IPv4 addresses required, must be a power of 2 and minimum value is 8. This option is mutually exclusive with --ipv4-cidr-block
#     --zone value                 Name of the zone
#     --network-acl-id value       The ID of the network ACL.
#     --public-gateway-id value    The ID of the public gateway.
#     --routing-table-id value     The ID of the routing table.
#     --resource-group-id value    ID of the resource group. This option is mutually exclusive with --resource-group-name
#     --resource-group-name value  Name of the resource group. This option is mutually exclusive with --resource-group-id
#     --output value               Specify output format, only JSON is supported now. Enumeration type: JSON.
#     -q, --quiet                  Suppress verbose output
#
