

data "ibm_resource_group" "default" {
  name = "Default"
}

output "resource_group" {
  value = data.ibm_resource_group.default
}

output "resource_group_id" {
  value = data.ibm_resource_group.default.id
}

