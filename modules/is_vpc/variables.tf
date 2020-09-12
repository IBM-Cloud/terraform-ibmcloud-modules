#########1#########2#########3#########4#########5#########6#########7#########8
# VPC variables
#########1#########2#########3#########4#########5#########6#########7#########8
variable "vpc_name" {
  description = "The name of the VPC"
}

variable "address_prefix_management" {
  description = "Adress prefix management"
  default     = "auto"
}

variable "resource_group_name" {
  description = "The resource group id where you want to create the VPC"
  default     = "Default"
}

variable "classic_access" {
  description = "Specify if you want to create a VPC that will can connect to classic infrastructure"
  default     = false
}
