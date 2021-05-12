

output "instances" {
  value = ibm_is_instance.this
}

output "instance_ids" {
  value = [for instance in ibm_is_instance.this: instance.id]
}
