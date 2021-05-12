

variable vpc_id {}
variable name {}
variable region {}
variable target_provider {}
variable resource_group_id {}

resource "shell_script" "egw" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create_egw.sh")
    update = file("${path.module}/scripts/update_egw.sh")
    read   = file("${path.module}/scripts/read_egw.sh")
    delete = file("${path.module}/scripts/delete_egw.sh")
  }

  environment = {
    VPC_ID            = var.vpc_id
    NAME              = var.name
    REGION            = var.region
    TARGET_PROVIDER   = var.target_provider
    RESOURCE_GROUP_ID = var.resource_group_id
  }
}

output "egw" {
  value = shell_script.egw.output
}

