# IBM Confidential
# OCO Source Materials
# CLD-86123-1617860268
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable region {}
variable zone {}
variable resource_group_id {}
variable share_name {}
variable share_profile {}
variable share_size {}
variable share_count {}

resource "shell_script" "shares" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }

  count = var.share_count
  environment = {
    REGION            = var.region
    ZONE	      = var.zone
    RESOURCE_GROUP_ID = var.resource_group_id
    SHARE_NAME        = "${var.share_name}-${count.index}"
    SHARE_PROFILE     = var.share_profile
    SHARE_SIZE        = var.share_size
  }
}

output "shares" {
  value = [for item in shell_script.shares: item.output]
}

output "share_ids" {
  value = [for item in shell_script.shares: item.output.id]
}
