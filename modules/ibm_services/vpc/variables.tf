

variable "prefix" {
  description = "Prefix for resources for easy identification"
}

variable "vpc_count" {
  description = "Number of VPCs you would like to create"
  default     = 1
}

variable "zone1" {
  default = "us-south-1"
}

variable "zone2" {
  default = "us-south-2"
}

variable "ssh_public_key" {
  default="test-public-key-v1-do-not-delete"
}

variable "image" {
  default = "99edcc54-c513-4d46-9f5b-36243a1e50e2"
}

variable "profile" {
  default = "cx2-2x4"
}
