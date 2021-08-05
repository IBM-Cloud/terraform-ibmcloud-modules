# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740431
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable "ibm_resource_group" {
  default     = "Default"
  description = "IBM Cloud resource group name"
}

data ibm_resource_group "resource_group" {
  name = var.ibm_resource_group
}

output ibm_resource_group_id {
  value = data.ibm_resource_group.resource_group.id
}

output ibm_resource_group {
  value = data.ibm_resource_group.resource_group
}
