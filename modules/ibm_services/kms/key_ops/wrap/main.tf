

variable region {}
variable kms_endpoint {}
variable kms_instance_guid {}
variable kms_key_id {}
variable passphrase {}
variable resource_group_id {}

resource "shell_script" "wrap" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  environment = {
    REGION            = var.region
    KMS_ENDPOINT      = var.kms_endpoint
    KMS_INSTANCE_GUID = var.kms_instance_guid
    KMS_KEY_ID        = var.kms_key_id
    PASSPHRASE        = var.passphrase
    RESOURCE_GROUP_ID = var.resource_group_id
  }
}

output "wrap" {
  value = shell_script.wrap.output
}
