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

variable "volume_ids" {
  description = "Data volume ids"
  type        = list(string)
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

variable "placement_target" {
  description = "The placement for the virtual server instance"
  type        = string
  default     = ""
}
