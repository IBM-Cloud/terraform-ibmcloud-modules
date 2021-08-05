

variable "prefix" {
  description = "Prefix for resources for easy identification"
}

variable "sg_count" {
  description = "Number of security groups you would like to create"
  default     = 1
}

variable "vpc_id" {
  description = "VPC id of where the security group will be applied to"
}
