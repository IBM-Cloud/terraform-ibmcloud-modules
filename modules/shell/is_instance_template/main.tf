# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740553
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


resource "shell_script" "is_instance_template" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    #read = file("${path.module}/scripts/read.sh")
    #update = file("${path.module}/scripts/update.sh")
  }
  environment = {
    IBM_REGION = var.ibm_region
    VPC_ID = var.vpc_id
    ZONE_NAME = var.zone_name
    PROFILE_NAME = var.profile_name
    SUBNET_ID = var.subnet_id
    IMAGE_ID = var.image_id
    IT_NAME = var.it_name
    KEYS = var.keys
    USER_DATA = var.user_data
    RESOURCE_GROUP_ID = var.resource_group_id
  }
}

#output "id" {
#  value = shell_script.is_vpc.output["id"]
#}
#
#output "name" {
#  value = shell_script.is_vpc.output["name"]
#}

variable ibm_region {}
variable vpc_id {}
variable zone_name {}
variable profile_name {}
variable subnet_id {}
variable image_id {}
variable it_name {}
variable keys {}
variable user_data {}
variable resource_group_id {}

output "is_it" {
  value = shell_script.is_instance_template.output
}
