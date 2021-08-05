

output "volumes" {
  value = ibm_is_volume.this
}

output "volume_ids" {
  value = [for volume in ibm_is_volume.this: volume.id]
}


output "instances" {
  value = ibm_is_instance.this
}

output "instance_ids" {
  value = [for instance in ibm_is_instance.this: instance.id]
}
