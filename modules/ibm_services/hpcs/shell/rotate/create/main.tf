

variable region {}
variable kms_instance_guid {}
variable kms_key_id {}
variable resource_group_id {}

resource "shell_script" "rotate" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  environment = {
    IBM_REGION        = var.region
    KMS_INSTANCE_GUID = var.kms_instance_guid
    KMS_KEY_ID        = var.kms_key_id
    RESOURCE_GROUP_ID = var.resource_group_id
  }
}

output "rotate" {
  value = shell_script.rotate.output
}
