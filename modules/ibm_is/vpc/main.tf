

#########1#########2#########3#########4#########5#########6#########7#########8
# VPC variables
#########1#########2#########3#########4#########5#########6#########7#########8
variable "vpc_name" {
  description = "VPC name"
}

variable "address_prefix_management" {
  description = "Adress prefix management"
  default     = "manual"
}

variable "resource_group_id" {
  description = "Resource group id"
}

#########1#########2#########3#########4#########5#########6#########7#########8
# VPC address prefix variables
#########1#########2#########3#########4#########5#########6#########7#########8
variable "vpc_address_prefix_name" {
  description = "VPC address prefix name"
}

variable "zone_vpc_address_prefix" {
  description = "Map of zone vpc_adress_prefix"
  type        = map(string)
}

#########1#########2#########3#########4#########5#########6#########7#########8
# Resources
#########1#########2#########3#########4#########5#########6#########7#########8
resource "ibm_is_vpc" "this" {
  name           	    = var.vpc_name 
  address_prefix_management = var.address_prefix_management
  resource_group            = var.resource_group_id
}

resource "ibm_is_vpc_address_prefix" "this" {
  for_each = var.zone_vpc_address_prefix
  name     = "${each.key}-${var.vpc_address_prefix_name}"
  zone     = each.key
  vpc      = ibm_is_vpc.this.id
  cidr     = each.value
}

#########1#########2#########3#########4#########5#########6#########7#########8
# Outputs
#########1#########2#########3#########4#########5#########6#########7#########8
output "vpc" {
  value = ibm_is_vpc.this
}

output "vpc_id" {
  value = ibm_is_vpc.this.id
}

output "vpc_address_prefix_ids" {
  value = {for zone, value in ibm_is_vpc_address_prefix.this: zone => value.id}
}

output "vpc_default_security_group" {
  value = ibm_is_vpc.this.default_security_group
}
