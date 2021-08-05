

resource "shell_script" "is_ig_schedule_manager_action" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    read   = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }
  environment = {
    IBM_REGION       = var.ibm_region
    RESOURCE_GROUP   = var.resource_group
    IG_ID            = var.ig_id
    IGM_ID           = var.igm_id
    IGMA_NAME        = var.igma_name
    RUNAT            = var.runat
    CRON             = var.cron
    MEMBERSHIP_COUNT = var.membership_count
    MIN_MEMBERS      = var.min_members
    MAX_MEMBERS      = var.max_members

  }
}

variable "ibm_region" {}
variable "resource_group" {}
variable "ig_id" {}
variable "igm_id" {}
variable "igma_name" {}
variable "runat" {}
variable "cron" {}
variable "membership_count" {}
variable "min_members" {}
variable "max_members" {}

output "is_ig_schedule_manager_action" {
  value = shell_script.is_ig_schedule_manager_action.output
}
