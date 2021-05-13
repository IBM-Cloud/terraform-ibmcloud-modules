

resource "shell_script" "is_instance_group_manager_policies" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
  }
  count = var.ig_count
  environment = {
    IBM_REGION = var.ibm_region
    IG_ID = var.ig_id[count.index].id
    IGM_ID = var.igm_id[count.index].id
    METRIC_TYPE = var.metric_type
    METRIC_VALUE = var.metric_value
  }
}

variable ibm_region {}
variable ig_id {}
variable igm_id {}
variable metric_type {}
variable metric_value {}
variable ig_count {}

output "is_igmps" {
  value = shell_script.is_instance_group_manager_policies
}
