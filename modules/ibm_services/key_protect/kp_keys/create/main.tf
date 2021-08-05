# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740491
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable "kp_instance_guid" {
  description = "Key protect instance guid"
}

variable "kp_key_count" {
  description = "The number of key protect keys"
  type        = number
  default     = 1
}

variable "key_name" {
  description = "Key protect key name"
}

resource "ibm_kp_key" "this" {
  count          = var.kp_key_count
  key_protect_id = var.kp_instance_guid
  key_name       = "${var.key_name}-${count.index}"
}

output "kp_keys" {
  value = ibm_kp_key.this
}

output "kp_key_ids" {
  value = [for item in ibm_kp_key.this: item.key_id]
}

output "kp_key_crns" {
  value = [for item in ibm_kp_key.this: item.crn]
}
