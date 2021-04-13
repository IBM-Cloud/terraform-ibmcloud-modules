# IBM Confidential
# OCO Source Materials
# CLD-85275-1615443839
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


resource "shell_script" "is_ig_schedule_manager" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    read   = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }
  environment = {
    IBM_REGION     = var.ibm_region
    RESOURCE_GROUP = var.resource_group
    IG_ID          = var.ig_id
    IGM_NAME       = var.igm_name
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "ibm_region" {}
variable "resource_group" {}
variable "ig_id" {}
variable "igm_name" {}

output "is_ig_schedule_manager" {
  value = shell_script.is_ig_schedule_manager.output
}
