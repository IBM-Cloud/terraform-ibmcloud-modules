output "floating_ip" {
  value = ibm_is_floating_ip.this
}

output "floating_ip_name" {
  value = ibm_is_floating_ip.this.name
}
