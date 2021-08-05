

resource "shell_script" "is_vpc_routing_table" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }
  environment = {
    IBM_REGION = var.ibm_region
    RESOURCE_GROUP = var.resource_group
    VPC_ID = var.vpc_id
    VPC_RTBL_NAME = var.vpc_rtbl_name
    DIRECT_LINK_VALUE = var.direct_link_value
    TRANSIT_GATEWAY_VALUE = var.transit_gateway_value
    VPC_ZONE_VALUE = var.vpc_zone_value
  }
}

variable vpc_id {}
variable vpc_rtbl_name {}
variable ibm_region {}
variable resource_group {}
variable direct_link_value { default = ""}
variable transit_gateway_value { default = "" }
variable vpc_zone_value { default = "" }

output "is_vpc_routing_table" {
  value = shell_script.is_vpc_routing_table.output
}

# [brad@reason system-tf-base]$ ibmcloud is vpc-rtblc --help
# NAME:
#     vpc-routing-table-create - Create a VPC routing table
  
# USAGE:
#     ibmcloud is vpc-routing-table-create VPC [--name NAME] [--direct-link false | true] [--transit-gateway false | true] [--vpc-zone false | true] [--output JSON] [-q, --quiet]
#     VPC: ID of the VPC.

# EXAMPLE:
#     ibmcloud is vpc-routing-table-create 72b27b5c-f4b0-48bb-b954-5becc7c1dcb3 --name my-vpc-routing-table --output JSON
  
# OPTIONS:
#     --name value             Name of the VPC routing table.
#     --direct-link value      If set to "true", this routing table is used to route traffic that originates from Direct Link to this VPC. For this route to succeed, the VPC must not already have a routing table with this property set to "true". One of: false, true.
#     --transit-gateway value  If set to "true", this routing table is used to route traffic that originates from Transit Gateway to this VPC. For this route to succeed, the VPC must not already have a routing table with this property set to "true". One of: false, true.
#     --vpc-zone value         If set to "true", this routing table is used to route traffic that originates from subnets in other zones in this VPC. For this route to succeed, the VPC must not already have a routing table with this property set to "true". One of: false, true.
#     --output value           Specify output format, only JSON is supported now. One of: JSON.
#     -q, --quiet              Suppress verbose output

