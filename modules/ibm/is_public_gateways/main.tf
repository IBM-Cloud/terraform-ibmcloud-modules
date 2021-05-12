
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

resource ibm_is_public_gateway "is_pubgws" {
  for_each = var.ibm_zone_address_prefix
  vpc      = var.vpc
  zone     = each.key
  name     = "${var.prefix}-${each.key}-pgw"
}

output is_pubgws {
  value = ibm_is_public_gateway.is_pubgws
}
