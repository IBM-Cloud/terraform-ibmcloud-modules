# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740450
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


# instance variables
variable "vsi_count" {
  description = "The number of VSIs will be created"
  type        = number
}

variable "vsi_name" {
  description = "Virtual server instance name"
}

variable "vpc_id" {
  description = "VPC id"
}

variable "zone" {
  description = "Zone name"
}

variable "image_id" {
  description = "Image id"
}

variable "profile" {
  description = "Profile name"
}

variable "ssh_key_id" {
  description = "Ssh key id"
}

variable "user_data" {
  description = "User data for cloud-init"
}

variable "bv_name" {
  description = "Boot volume name"
}

variable "bv_encryption" {
  description = "Boot volume encryption"
}

variable "primary_nif_name" {
  description = "Primary network interface name"
}

variable "subnet_id" {
  description = "subnet id"
}

variable "resource_group_id" {
  description = "Resource group id"
}

variable "sg_id" {
  description = "Security group id"
}

variable "vsi_depends_on" {
  description = "Resources are depended by VSIs"
}

# Data volume variables
variable "vol_count" {
  description = "The number of volumes will be created"
  type        = number
  default     = 0
}

variable "vol_name" {
  description = "Volume name"
}

variable "vol_profile" {
  description = "Volume profile"
  default     = "10iops-tier"
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

variable "placement_target" {
  description = "The placement for the virtual server instance"
  type        = string
  default     = ""
}
