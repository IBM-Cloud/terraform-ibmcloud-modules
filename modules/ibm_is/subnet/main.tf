

variable "subnet_name" {
  description = "Subnet name"
}

variable "vpc_id" {
  description = "VPC id"
}

variable "zone" {
  description = "Zone name"
}

variable "resource_group_id" {
  description = "Resource group id"
}

variable "ipv4_cidr_block" {
  description = "IPv4 cidr block"
}

variable "public_gateway_id" {
  description = "Public gateway id"
  default     = ""
}

variable "subnet_depends_on" {
  description = "Non-default subnets depends on vpc address prefix"
  type        = map(string)
}

resource "ibm_is_subnet" "this" {
  name 	          = "${var.zone}-${var.subnet_name}"
  vpc 		  = var.vpc_id
  zone 		  = var.zone
  resource_group  = var.resource_group_id
  ipv4_cidr_block = var.ipv4_cidr_block
  public_gateway  = var.public_gateway_id
 
  depends_on      = [var.subnet_depends_on]
}

output "subnet" {
  value = ibm_is_subnet.this
}

output "subnet_id" {
  value = ibm_is_subnet.this.id
}
