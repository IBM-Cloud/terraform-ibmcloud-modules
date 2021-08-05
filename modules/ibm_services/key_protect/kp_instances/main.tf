

variable "kp_instance_count" {
  description = "The number of kp resource instances"
  type        = number
  default     = 1
}

variable "kp_instance_name" {
  description = "Key protect service name"
}

variable "service_name" {
  description = "Service name"
  default     = "kms"
}

variable "plan" {
  description = "Service plan"
  default     = "tiered-pricing"
}

variable "location" {
  description = "The location on which the service is created"
  default     = "us-south"
}

variable "resource_group_id" {
  description = "Resource group id"
}

resource "ibm_resource_instance" "this" {
  count             = var.kp_instance_count
  name              = "${var.kp_instance_name}-${count.index}"
  service           = var.service_name
  plan              = var.plan
  location          = var.location
  resource_group_id = var.resource_group_id
}

output "kp_instances" {
  value = ibm_resource_instance.this
}

output kp_instance_guids {
  value = [for item in ibm_resource_instance.this: item.guid]
}

