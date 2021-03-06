output "security_group" {
  value = ibm_is_security_group.this
}

output "security_group_id" {
  value = ibm_is_security_group.this.id
}

output "security_group_name" {
  value = ibm_is_security_group.this.name
}
