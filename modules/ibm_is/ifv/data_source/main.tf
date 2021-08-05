# IBM Confidential
# OCO Source Materials
# CLD-88229-16195113868
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable region {}
variable resource_group_id {}
variable ifv_ids {type=list}

data  "shell_script" "ifvs" {
  lifecycle_commands {
    read   = file("${path.module}/scripts/read.sh")
  }

  count = length(var.ifv_ids)
  environment = {
    SCRIPTS_PATH      = "${path.module}/scripts"
    REGION            = var.region
    RESOURCE_GROUP_ID = var.resource_group_id
    IFV_ID            = var.ifv_ids[count.index]
  }
}

output "ifvs" {
  value = [for item in data.shell_script.ifvs: item.output ]
}

output "ifvs_status" {
  value = {for item in data.shell_script.ifvs: item.output.id => item.output.status}
}
