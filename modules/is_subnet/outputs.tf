output "subnet" {
  value = ibm_is_subnet.this
}

output "subnet_id" {
  value = ibm_is_subnet.this.id
}

output "subnet_name" {
  value = ibm_is_subnet.this.name
}
