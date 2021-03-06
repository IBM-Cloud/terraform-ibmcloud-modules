

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
