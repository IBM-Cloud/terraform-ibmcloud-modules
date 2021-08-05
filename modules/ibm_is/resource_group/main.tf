# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740456
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable "rg_name" {
  description = "Resource group name" 
}

resource "ibm_resource_group" "this" {
  name = var.rg_name
}

output "resource_group" {
  value = ibm_resource_group.this
}

output "resource_group_id" {
  value = ibm_resource_group.this.id
}

