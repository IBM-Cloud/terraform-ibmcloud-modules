

variable region {}
variable vsi_count {}
variable vsi_name {}
variable vpc_id {}
variable zone {}
variable profile {}
variable image_id {}
variable ssh_key_id {}
variable user_data {}
variable bv_name {}
variable bv_profile {}
variable bv_encryption {}
variable primary_nif_name {}
variable subnet_id {}
variable sg_id {}
variable vol_attach {}
variable vol_ids {type=list(string)}
variable vol_name {}
variable vol_profile {}
variable vol_size {}
variable vol_encryption {}
variable resource_group_id {}
variable vsi_depends_on {}

resource "shell_script" "instances" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }

  count = var.vsi_count
  environment = {
    IBM_REGION        = var.region
    VSI_NAME          = "${var.zone}-${var.vsi_name}-${count.index}"
    VPC_ID            = var.vpc_id
    ZONE              = var.zone
    PROFILE           = var.profile
    IMAGE_ID          = var.image_id
    KEY_IDS           = var.ssh_key_id
    USER_DATA         = var.user_data
    BV_NAME           = "${var.zone}-${var.bv_name}-${count.index}"
    BV_PROFILE        = var.bv_profile
    BV_ENCRYPTION     = var.bv_encryption
    PRIMARY_NIF_NAME  = "${var.zone}-${var.primary_nif_name}"
    SUBNET_ID         = var.subnet_id
    SG_ID             = var.sg_id
    VOL_ATTACH        = var.vol_attach
    VOL_ID            = length(var.vol_ids) != 0 ?var.vol_ids[count.index]: ""
    VOL_NAME          = "${var.zone}-${var.vol_name}-${count.index}"
    VOL_PROFILE       = var.vol_profile
    VOL_SIZE          = var.vol_size
    VOL_ENCRYPTION    = var.vol_encryption
    RESOURCE_GROUP_ID = var.resource_group_id
  }

  depends_on = [
    var.vsi_depends_on,
  ]
}

output "instances" {
  value = [for item in shell_script.instances: item.output]
}

output "instance_ids" {
  value = [for item in shell_script.instances: item.output.id]
}
