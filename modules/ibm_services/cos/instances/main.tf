

variable "cos_instance_count" {
  description = "The number of cloud object storage service instances"
  type        = number
  default     = 1
}

variable "cos_instance_name" {
  description = "COS service instance name"
}

variable "service_name" {
  description = "Service name"
  default     = "cloud-object-storage"
}

variable "service_plan" {
  description = "Service plan"
  default     = "standard"
}

variable "service_location" {
  description = "The location on which the service is created"
  default     = "global"
}

variable "resource_group_id" {
  description = "Resource group id"
}

resource "ibm_resource_instance" "this" {
  count             = var.cos_instance_count
  name              = "${var.cos_instance_name}-${count.index}"
  service           = var.service_name
  plan              = var.service_plan
  location          = var.service_location
  resource_group_id = var.resource_group_id
}

output "cos_instances" {
  value = ibm_resource_instance.this
}

output cos_instance_guids {
  value = [for item in ibm_resource_instance.this: item.guid]
}
