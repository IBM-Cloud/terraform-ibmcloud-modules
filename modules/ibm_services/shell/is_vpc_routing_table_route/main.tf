

resource "shell_script" "is_vpc_routing_table_route" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }
  environment = {
    VPC_ID = var.vpc_id
    VPC_RTBL_ID = var.vpc_rtbl_id
    VPC_RTBL_RT_NAME = var.vpc_rtbl_rt_name
    ZONE_NAME = var.zone_name
    DESTINATION = var.destination
    NEXT_HOP = var.next_hop
    ACTION = var.action
    IBM_REGION = var.ibm_region
    RESOURCE_GROUP = var.resource_group
  }
}

variable vpc_id {}
variable vpc_rtbl_id {}
variable vpc_rtbl_rt_name {}
variable zone_name {}
variable destination {}
variable next_hop {}
variable action {}
variable ibm_region {}
variable resource_group {}

output "is_vpc_routing_table_route" {
  value = shell_script.is_vpc_routing_table_route.output
}

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
#
