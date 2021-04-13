# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740522
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


resource "shell_script" "is_instance_group" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
  }
  environment = {
    IBM_REGION = var.ibm_region
    IG_NAME = var.ig_name
    IT_ID = var.it_id
    SUBNET_ID = var.subnet_id
    MEMBERSHIP_COUNT = var.membership_count
    RESOURCE_GROUP_ID = var.resource_group_id
  }
}

variable ibm_region {}
variable ig_name {}
variable it_id {}
variable subnet_id {}
variable membership_count {}
variable resource_group_id {}

output "is_ig" {
  value = shell_script.is_instance_group.output
}
