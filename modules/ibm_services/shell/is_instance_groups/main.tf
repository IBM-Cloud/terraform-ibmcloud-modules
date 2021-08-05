

resource "shell_script" "is_instance_groups" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
  }
  count = var.ig_count
  environment = {
    IBM_REGION = var.ibm_region
    IG_NAME = "${var.ig_name}-${count.index}"
    IT_ID = var.it_id
    SUBNET_ID = var.subnet_id
    MEMBERSHIP_COUNT = var.membership_count
    RESOURCE_GROUP_ID = var.resource_group_id
  }
}

variable ibm_region {}
variable ig_name {}
variable it_id {}
variable subnet_id {}
variable membership_count {}
variable resource_group_id {}
variable ig_count {}

output "is_igs" {
  value = shell_script.is_instance_groups
}
