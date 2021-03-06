

resource "shell_script" "is_instance_group_manager" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
  }
  environment = {
    IBM_REGION = var.ibm_region
    IG_ID = var.ig_id
    MIN_MEMBERS = var.min_members
    MAX_MEMBERS = var.max_members
    AGGREGATION_WINDOW = var.aggregation_window
    COOLDOWN = var.cooldown
  }
}

variable ibm_region {}
variable ig_id {}
variable min_members {}
variable max_members {}
variable aggregation_window {}
variable cooldown {}

output "is_igm" {
  value = shell_script.is_instance_group_manager.output
}
