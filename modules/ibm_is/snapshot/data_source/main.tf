# IBM Confidential
# OCO Source Materials
# CLD-84025-1615393081
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable region {default="us-south"}
variable resource_group_id {}
variable snapshot_ids {type=list(string)}

data "shell_script" "snapshots" {
  lifecycle_commands {
    read   = file("${path.module}/scripts/read.sh")
  }

  count = length(var.snapshot_ids)
  environment = {
    SCRIPTS_PATH      = "${path.module}/scripts"
    REGION            = var.region
    RESOURCE_GROUP_ID = var.resource_group_id
    SNAPSHOT_ID       = var.snapshot_ids[count.index]
  }
}

output "snapshots" {
  value = [for item in data.shell_script.snapshots: item.output ]
}

output "snapshot_lifecycle_states" {
  value = {for item in data.shell_script.snapshots: item.output.id => item.output.lifecycle_state}
}

