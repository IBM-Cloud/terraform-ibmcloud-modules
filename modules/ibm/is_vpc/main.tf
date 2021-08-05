# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740430
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable "ibm_is_vpc_name" {
  description = "ibm is vpc name"
}

variable "ibm_resource_group_name" {
  description = "IBM resource group"
  default = "Default"
}

module "ibm_resource_group_id" {
  source = "../resource_group_id"
}

resource "random_string" "identifier" {
  length = 4
  upper = false
  lower = true
  special = false
  keepers = {
    vpc_id  = ibm_is_vpc.vpc.id
  }
}

resource "random_id" "prefix" {
  byte_length = 2
  #prefix = var.ibm_is_vpc_name
}

#resource "ibm_is_vpc" "basic_vpc" {
#  name          = "${random_id.prefix.hex}-vpc"
#}

resource ibm_is_vpc vpc {
  name           = "${var.ibm_is_vpc_name}-${random_id.prefix.hex}"
  resource_group = module.ibm_resource_group_id.ibm_resource_group_id
}

output ibm_is_vpc_id {
  value = ibm_is_vpc.vpc.id
}

output ibm_is_vpc {
  value = ibm_is_vpc.vpc
}

output unique_id {
  value = "ID"
}
