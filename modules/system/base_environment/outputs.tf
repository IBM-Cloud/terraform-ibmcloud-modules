

output "vpc" {
  value = module.vpc
}

output "worker_subnet" {
  value = module.worker_subnet
}

output "bastion_subnet" {
  value = module.bastion_subnet
}

output "security_group_worker" {
  value = module.security_group_worker
}

output "bastion" {
  value = ibm_is_instance.bastion
}

output "bastion_fip" {
  value = module.bastion_fip.floating_ip
}

output "public_key" {
  value = data.ibm_is_ssh_key.public_ssh_key
}
