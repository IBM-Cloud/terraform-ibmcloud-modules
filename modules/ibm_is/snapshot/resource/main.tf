

variable region {}
variable resource_group_id {}
variable snapshot_name {}
variable volume_ids {type = list}
variable snapshot_count {}

resource "shell_script" "snapshots" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }

  count = var.snapshot_count
  environment = {
    SCRIPTS_PATH      = "${path.module}/scripts"
    REGION            = var.region
    RESOURCE_GROUP_ID = var.resource_group_id
    SNAPSHOT_NAME     = "${var.snapshot_name}-${count.index}"
    VOLUME_ID         = var.volume_ids[count.index]
  }
}

output "snapshots" {
  value = [for item in shell_script.snapshots: item.output ]
}

output "snapshot_ids" {
  value = [for item in shell_script.snapshots: item.output.id]
}
