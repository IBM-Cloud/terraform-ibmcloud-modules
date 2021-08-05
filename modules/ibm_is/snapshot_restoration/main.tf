# IBM Confidential
# OCO Source Materials
# CLD-88676-1620634890
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable region {}
variable resource_group_id {}
variable instance_name {}
variable vpc_id {}
variable zone_name {default="us-south-1"}
variable instance_profile {default="bx2-2x8"}
variable subnet_ids {type=map(string)}
variable security_group_id {}
variable image_id {default="r134-ffa6a43c-9466-4fa9-823f-87c0d21c81a9"}
variable ssh_key_id {}
variable bv_snapshot_ids {type=list}
variable bv_profile {default="general-purpose"}
variable dv_snapshot_ids {type=list}
variable dv_deletion {default=true}
variable dv_profile {default="general-purpose"}
variable dv_capacity {default=10}
variable restoration_count {default=1}

resource "shell_script" "restorations" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }

  count = var.restoration_count
  environment = {
    SCRIPTS_PATH      = "${path.module}/scripts"
    REGION            = var.region
    RESOURCE_GROUP_ID = var.resource_group_id
    INSTANCE_NAME     = "${var.instance_name}-${count.index}"
    VPC_ID            = var.vpc_id
    ZONE_NAME         = var.zone_name
    INSTANCE_PROFILE  = var.instance_profile
    SUBNET_ID         = var.subnet_ids[var.zone_name]
    SECURITY_GROUP_ID = var.security_group_id
    IMAGE_ID          = var.image_id
    SSH_KEY_ID        = var.ssh_key_id
    BV_SNAPSHOT_ID    = length(var.bv_snapshot_ids) !=0 ? var.bv_snapshot_ids[count.index]: ""
    BV_ATTACH_NAME    = "bva-${var.instance_name}-${count.index}"
    BV_NAME           = "bv-${var.instance_name}-${count.index}"
    BV_PROFILE        = var.bv_profile
    DV_SNAPSHOT_ID    = length(var.dv_snapshot_ids) !=0 ?var.dv_snapshot_ids[count.index]: ""
    DV_DELETION       = var.dv_deletion
    DV_ATTACH_NAME    = "dva-${var.instance_name}-${count.index}"
    DV_NAME           = "dv-${var.instance_name}-${count.index}"
    DV_PROFILE        = var.dv_profile
    DV_CAPACITY       = var.dv_capacity
  }
}

output "restorations" {
  value = [for item in shell_script.restorations: item.output ]
}

output "restoration_ids" {
  value = [for item in shell_script.restorations: item.output.id]
}
