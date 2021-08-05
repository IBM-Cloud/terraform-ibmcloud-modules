

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

variable "payload" {
  description = "Key material payload"
}

resource "ibm_kp_key" "this" {
  count          = var.kp_key_count
  key_protect_id = var.kp_instance_guid
  key_name       = "${var.key_name}-${count.index}"
  payload        = var.payload
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
