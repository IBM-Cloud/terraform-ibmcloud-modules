

variable region {}
variable name {}
variable zone_name {}
variable family {}
variable class {}
variable resource_group_id {}

resource "shell_script" "dhg" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  environment = {
    REGION            = var.region
    NAME              = var.name
    ZONE_NAME         = var.zone_name
    FAMILY            = var.family
    CLASS             = var.class
    RESOURCE_GROUP_ID = var.resource_group_id
  }
}

output "dhg" {
  value = shell_script.dhg.output
}
