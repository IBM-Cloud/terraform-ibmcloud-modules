variable "suffix" {
  description = "Unique identifier for the environment that will be created"
}

variable "region_list" {
  description = "The region list that we will use to spin up resources in"
  default = ["us-south"]
}

variable "zone" {
  description = "The zones that the resources will be put in"
  default = "us-south-1"
}

variable "bastion_image_id" {
  default = "r134-ed3f775f-ad7e-4e37-ae62-7199b4988b00"
}

variable "profile" {
  default = "cx2-2x4"
}

variable "bastion_ipv4_cidr" {
}

variable "worker_ipv4_cidr" {
}

variable "zone_vpc_address_prefix" {
  description = "Zone vpc address prefix map"
  type        = map(string)

}

variable "resource_group" {
  description = "The resource group that will be used for the infrastructure"
  default     = "Default"
}

################### Instance Counts #################
variable "ubuntu_worker_count" {
  description = "Number of ubuntu instances per VPC you would like to spin up"
  default = 1
}



#################### Images #######################
# 1804
variable "ubuntu_image" {
  default ="r134-ed3f775f-ad7e-4e37-ae62-7199b4988b00"
}


##### NOT USED FOR FUTURE WORK #####
/*variable "win_profile" {
  default = "ccx2-2x4"
}

variable "centos_worker_count" {
  description = "Number of centos worker instances per VPC you would like to spin up"
  default = 0
}

variable "windows_worker_count" {
  description = "Number of windows worker instances per VPC you would like to spin up"
  default = 0
}


# 7.6
variable "centos_image" {
  default ="r134-6f153a5d-6a9a-496d-8063-5c39932f6ded"
}

# 9.12
variable "debian_image" {
  default ="r134-ea70cf5b-93f0-4871-a31e-f0030484149e"
}

# 7.6
variable "redhat_image" {
  default ="r134-931515d2-fcc3-11e9-896d-3baa2797200f"
}

# Server 2012 r2
variable "windows_2012_image" {
  default ="r134-8bb3e8aa-b789-4292-8679-3564b3a9366a"
}

# Server 2016
variable "windows_2016_image" {
  default ="r134-54e9238a-ffdd-4f90-9742-7424eb2b9ff1"
}




*/
