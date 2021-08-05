

variable "ssh_key_name" {
  description = "Ssh key name"
}

variable "public_key" {
  description = "Ssh public key"
}

variable "resource_group_id" {
  description = "Resource group id"
}

resource "ibm_is_ssh_key" "this" {
  name           = var.ssh_key_name
  public_key     = var.public_key
  resource_group = var.resource_group_id
}

output "ssh_key" {
  value = ibm_is_ssh_key.this
}

output "ssh_key_id" {
  value = ibm_is_ssh_key.this.id
}
