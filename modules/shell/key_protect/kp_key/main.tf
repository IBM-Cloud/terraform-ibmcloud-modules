# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740584
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable region {}
variable name {}
variable kp_instance_id {}

resource "shell_script" "kp_key" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  environment = {
    IBM_REGION     = var.region
    NAME           = var.name
    KP_INSTANCE_ID = var.kp_instance_id
  }
}

output "kp_key" {
  value = shell_script.kp_key.output
}
