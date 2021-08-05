# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740454
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


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
