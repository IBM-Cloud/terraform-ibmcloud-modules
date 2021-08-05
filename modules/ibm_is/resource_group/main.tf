

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

