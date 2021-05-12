

variable "subnet_name" {
  description = "Subnet name"
}

variable "zone_ipv4_cidr_block" {
  description = "Zone ipv4 cidr block map"
  type        = map(string)
}

variable "vpc_id" {
  description = "VPC id"
}

variable "resource_group_id" {
  description = "Resource group id"
}

variable "public_gateway_ids" {
  description = "Public gateway ids"
  type        = map(string)
}

variable "subnet_depends_on" {
  description = "Non-default subnets depends on vpc address prefix"
  type        = map(string)
}

resource "ibm_is_subnet" "this" {
  for_each        = var.zone_ipv4_cidr_block
  name 	          = "${each.key}-${var.subnet_name}"
  vpc 		  = var.vpc_id
  zone 		  = each.key
  resource_group  = var.resource_group_id
  ipv4_cidr_block = each.value
  public_gateway  = var.public_gateway_ids[each.key]
 
  depends_on      = [var.subnet_depends_on]
}

output "subnets" {
  value = ibm_is_subnet.this
}

output "subnet_ids" {
  value = {for zone, subnet in ibm_is_subnet.this: zone => subnet.id}
}
