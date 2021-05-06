

variable region {}
variable resource_group_id {}
variable ifv_base_name {}
variable source_volume_ids {type = list}
variable encryption_key {}

resource "shell_script" "ifvs" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }

  count = length(var.source_volume_ids)
  environment = {
    SCRIPTS_PATH      = "${path.module}/scripts"
    REGION            = var.region
    RESOURCE_GROUP_ID = var.resource_group_id
    IFV_NAME          = "${var.ifv_base_name}-${count.index}"
    SOURCE_VOLUME_ID  = var.source_volume_ids[count.index]
    ENCRYPTION_KEY    = var.encryption_key
  }
}

output "ifvs" {
  value = [for item in shell_script.ifvs: item.output ]
}

output "ifv_ids" {
  value = [for item in shell_script.ifvs: item.output.id]
}
