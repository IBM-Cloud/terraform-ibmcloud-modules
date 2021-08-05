# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740499
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


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
