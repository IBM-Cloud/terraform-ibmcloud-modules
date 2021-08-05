# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740428
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.



variable "prefix" {
  default     = "prefix"
  description = "The prefix string"
}

variable "use_personal_ssh" {
  description = "Flag to use personal ssh or temporarily generated"
  default = false
}

resource "tls_private_key" "insecure" {
  algorithm = "RSA"
  rsa_bits = 4096
}

locals {
  ssh-key-public = var.use_personal_ssh ? file(pathexpand("~/.ssh/test-public-key-v1-do-not-delete")) : tls_private_key.insecure.public_key_openssh
  ssh-key-private = var.use_personal_ssh ? file(pathexpand("~/.ssh/test-private-key-v1-do-not-delete")) : tls_private_key.insecure.private_key_pem
}

resource "ibm_is_ssh_key" "public-sshkey" {
  name       = "${var.prefix.hex}-generated-public-key"
  public_key = local.ssh-key-public
}

output "ssh_key_private" {
  value = local.ssh-key-private
}

output "ssh_key_public" {
  value = local.ssh-key-public
}
