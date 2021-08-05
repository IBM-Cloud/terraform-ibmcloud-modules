

variable "public_gateway_name" {
  description = "Public gateway name"
}

variable "zone_vpc_address_prefix" {
  description = "Zone vpc address prefix map"
  type        = map(string)
}

variable "vpc_id" {
  description = "VPC id"
}

variable "resource_group_id" {
  description = "Resource group id"
}

resource "ibm_is_public_gateway" "this" {
    for_each       = var.zone_vpc_address_prefix
    name           = "${each.key}-${var.public_gateway_name}"
    vpc            = var.vpc_id
    zone           = each.key
    resource_group = var.resource_group_id
}

output "public_gateways" {
  value = ibm_is_public_gateway.this
}

output "public_gateway_ids" {
  value = {for zone, pgw in ibm_is_public_gateway.this: zone => pgw.id }
}
