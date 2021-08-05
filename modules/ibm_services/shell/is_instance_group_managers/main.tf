# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740542
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


resource "shell_script" "is_instance_group_managers" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
  }
  count = var.ig_count
  environment = {
    IBM_REGION = var.ibm_region
    IG_ID = var.ig_id[count.index].id
    MIN_MEMBERS = var.min_members
    MAX_MEMBERS = var.max_members
    AGGREGATION_WINDOW = var.aggregation_window
    COOLDOWN = var.cooldown
  }
}

variable ibm_region {}
variable ig_id {}
variable min_members {}
variable max_members {}
variable aggregation_window {}
variable cooldown {}
variable ig_count {}

output "is_igms" {
  value = shell_script.is_instance_group_managers
}
