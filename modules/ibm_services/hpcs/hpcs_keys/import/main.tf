# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740477
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable "kms_instance_guid" {
  description = "KMS instance guid"
}

variable "key_count" {
  description = "The number of KMS root keys"
  type        = number
  default     = 1
}

variable "key_name" {
  description = "KMS root key name"
}

variable "payload" {
  description = "Key material payload"
}

resource "ibm_kms_key" "this" {
  count       = var.key_count
  instance_id = var.kms_instance_guid
  key_name    = "${var.key_name}-${count.index}"
  payload     = var.payload
}

output "kms_keys" {
  value = ibm_kms_key.this
}

output "kms_key_ids" {
  value = [for item in ibm_kms_key.this: item.key_id]
}

output "kms_key_crns" {
  value = [for item in ibm_kms_key.this: item.crn]
}
