# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740567
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


resource "shell_script" "is_rt_subnet" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }

  environment = {
    IBM_REGION     = var.ibm_region
    RESOURCE_GROUP = var.resource_group
    VPC_ID         = var.vpc_id
    ZONE           = var.zone

    SUBNET_NAME        = var.subnet_name
    IPV4_CIDR_BLOCK    = var.ipv4_cidr_block
    IPV4_ADDRESS_COUNT = var.ipv4_address_count
    NETWORK_ACL_ID     = var.network_acl_id
    PUBLIC_GATEWAY_ID  = var.public_gateway_id
    ROUTING_TABLE_ID   = var.routing_table_id
    RESOURCE_GROUP_ID  = var.resource_group_id

  }

}

variable ibm_region {}
variable resource_group {}
variable vpc_id {}
variable zone {}

variable ipv4_cidr_block {}
variable ipv4_address_count {}
variable network_acl_id {}
variable public_gateway_id {}
variable routing_table_id {}
variable resource_group_id {}
variable subnet_name {}

output "is_rt_subnet" {
  value = shell_script.is_rt_subnet.output
}

# # ic is subnetc --help
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
