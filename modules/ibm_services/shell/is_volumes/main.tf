

variable region {}
variable vol_count {}
variable zone {default = "us-south-1"}
variable vol_name {}
variable vol_profile {}
variable vol_size {}
variable vol_encryption {}
variable resource_group_id {}

resource "shell_script" "volumes" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }

  count = var.vol_count
  environment = {
    IBM_REGION        = var.region
    ZONE              = var.zone
    VOL_NAME          = "${var.zone}-${var.vol_name}-${count.index}"
    VOL_PROFILE       = var.vol_profile
    VOL_SIZE          = var.vol_size
    VOL_ENCRYPTION    = var.vol_encryption
    RESOURCE_GROUP_ID = var.resource_group_id
  }
}

output "volumes" {
  value = [for item in shell_script.volumes: item.output]
}

output "volume_ids" {
  value = [for item in shell_script.volumes: item.output.id]
}
