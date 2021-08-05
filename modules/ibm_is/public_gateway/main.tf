

variable "public_gateway_name" {
  description = "Public gateway name"
}

variable "vpc_id" {
  description = "VPC id"
}

variable "zone" {
  description = "Zone name"
}

variable "resource_group_id" {
  description = "Resouce group id"
}

resource "ibm_is_public_gateway" "this" {
    name           = "${var.zone}-${var.public_gateway_name}"
    vpc            = var.vpc_id
    zone           = var.zone
    resource_group = var.resource_group_id
}

output "public_gateway" {
  value = ibm_is_public_gateway.this
}

output "public_gateway_id" {
  value = ibm_is_public_gateway.this.id
}
