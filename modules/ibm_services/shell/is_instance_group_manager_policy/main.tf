

resource "shell_script" "is_instance_group_manager_policy" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
  }
  environment = {
    IBM_REGION = var.ibm_region
    IG_ID = var.ig_id
    IGM_ID = var.igm_id
    METRIC_TYPE = var.metric_type
    METRIC_VALUE = var.metric_value
  }
}

variable ibm_region {}
variable ig_id {}
variable igm_id {}
variable metric_type {}
variable metric_value {}

output "is_igmp" {
  value = shell_script.is_instance_group_manager_policy.output
}
