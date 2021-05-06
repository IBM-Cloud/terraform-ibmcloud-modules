

variable region {}
variable name {}
variable host_group_id {}
variable profile {}
variable enabled {default=true}
variable resource_group_id {}
variable dh_count {}

resource "shell_script" "dhs" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  count = var.dh_count
  environment = {
    REGION            = var.region
    NAME              = "${var.name}-${count.index}"
    HOST_GROUP_ID     = var.host_group_id
    PROFILE           = var.profile
    ENABLED           = var.enabled
    RESOURCE_GROUP_ID = var.resource_group_id
  }
}

output "dhs" {
  value = [for item in shell_script.dhs: item.output]
}
