# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740462
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable "vol_count" {
  description = "Volume count"
  type        = number
  default     = 1
}

variable "vol_name" {
  description = "Volume name"
}

variable "vol_profile" {
  description = "Volume profile"
  default     = "10iops-tier"
}

variable "zone" {
  description = "Zone name"
}

variable "vol_size_in_gb" {
  description = "Volume size in GB"
  type        = number
  default     = 10
}

variable "encryption_key" {
  description = "Volume encryption key"
  default     = ""
}

variable "resource_group_id" {
  description = "Resource group id"
}

resource "ibm_is_volume" "this" {
  count          = var.vol_count
  name           = "${var.zone}-${var.vol_name}-${count.index}"
  profile        = var.vol_profile
  zone           = var.zone
  capacity       = var.vol_size_in_gb
  encryption_key = var.encryption_key
  resource_group = var.resource_group_id
}

output "volumes" {
  value = ibm_is_volume.this
}

output "volume_ids" {
  value = [for volume in ibm_is_volume.this: volume.id]  
}
