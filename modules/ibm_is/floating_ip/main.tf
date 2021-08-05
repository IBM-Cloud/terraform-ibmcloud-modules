# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740446
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable "floating_ip_name" {
  description = "Floating ip name"
}

variable "floating_ip_target" {
  description = "Floating ip target"
}

resource "ibm_is_floating_ip" "this" {
  name   = var.floating_ip_name
  target = var.floating_ip_target
}

output "floating_ip" {
  value = ibm_is_floating_ip.this
}
