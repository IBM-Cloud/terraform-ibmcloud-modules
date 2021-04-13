data "shell_script" "is_ig_schedule_manager" {
  lifecycle_commands {
    read = file("${path.module}/scripts/read.sh")
  }
  environment = {
    IBM_REGION     = var.ibm_region
    RESOURCE_GROUP = var.resource_group
    IG_ID          = var.ig_id
    IGM_ID         = var.igm_id
  }
}

variable "ibm_region" {}
variable "resource_group" {}
variable "ig_id" {}
variable "igm_id" {}

output "data_is_ig_schedule_manager" {
  value = data.shell_script.is_ig_schedule_manager.output
}
