


variable "prefix" {
  default     = "prefix"
  description = "The prefix string"
}

variable "ibm_zone_address_prefix" {
  description = "Default 'Zone/Address Prefix' for us-south region"
  default = {
    # default: us-south-1 = "10.240.0.0/18"
    # default: us-south-2 = "10.240.64.0/18"
    # default: us-south-3 = "10.240.128.0/18"
    us-south-1 = "10.240.0.0/22"
    us-south-2 = "10.240.64.0/22"
    us-south-3 = "10.240.128.0/22"
  }
}

variable "vpc" {
  description = "VPC that Public GW will be provisioned"
}

variable "ip_version" {
  description = "IP Version"
  default = "ipv4"
}

variable "public_gateways" {
  description = "Public Gateways per Zone"
  type        = map
}

resource ibm_is_subnet "is_subnets" {
  for_each        = var.ibm_zone_address_prefix
  name            = "${var.prefix}-${each.key}-subnet"
  vpc             = var.vpc
  zone            = each.key
  #ip_version      = var.ip_version
  ipv4_cidr_block = each.value
  public_gateway = var.public_gateways[each.key].id
}

output is_subnets {
  value = ibm_is_subnet.is_subnets
}
