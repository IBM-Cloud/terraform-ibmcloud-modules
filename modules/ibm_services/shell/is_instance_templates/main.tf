

resource "shell_script" "is_instance_templates" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    #read = file("${path.module}/scripts/read.sh")
    #update = file("${path.module}/scripts/update.sh")
  }

  for_each = var.ibm_zone_address_prefix
  environment = {
    IBM_REGION = var.ibm_region
    VPC_ID = var.vpc_id
    ZONE_NAME = each.key
    PROFILE_NAME = var.profile_name
    SUBNET_ID = var.ibm_is_subnets[each.key].id
    IMAGE_ID = var.image_id
    IT_NAME = "${var.prefix}-${each.key}-it"
    KEYS = var.keys
    USER_DATA = var.user_data
    RESOURCE_GROUP_ID = var.resource_group_id
  }
}

variable prefix {}
variable ibm_zone_address_prefix {}
variable ibm_is_subnets {}

variable ibm_region {}
variable vpc_id {}
variable profile_name {}
variable image_id {}
variable keys {}
variable user_data {}
variable resource_group_id {}

output "is_its" {
  value = shell_script.is_instance_templates
}
