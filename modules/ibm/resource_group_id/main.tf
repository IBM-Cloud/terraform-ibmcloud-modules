

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
