output "vpc" {
  value = ibm_is_vpc.this
}

output "vpc_id" {
  value = ibm_is_vpc.this.id
}

output "vpc_name" {
  value = ibm_is_vpc.this.name
}