# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740500
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


data "shell_script" "is_instance" {
  lifecycle_commands {
    read = file("${path.module}/scripts/read.sh")
  }

  environment = {
    IBM_REGION     = var.ibm_region
    RESOURCE_GROUP = var.resource_group
    INSTANCE_ID = var.instance_id

  }
}

variable ibm_region {}
variable resource_group {}
variable instance_id {}


output "is_instance" {
  value = data.shell_script.is_instance.output
}
