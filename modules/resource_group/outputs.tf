output resource_group_id {
  value = data.ibm_resource_group.resource_group.id
}

output resource_group {
  value = data.ibm_resource_group.resource_group
}
