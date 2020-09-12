output "vpc" {
  value = ibm_is_vpc.this
}

output "vpc_id" {
  value = ibm_is_vpc.this.id
}
