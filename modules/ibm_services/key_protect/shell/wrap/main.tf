

variable region {}
variable kp_instance_id {}
variable kp_key_id {}
variable passphrase {}
variable resource_group_id {}

resource "shell_script" "wrap" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  environment = {
    IBM_REGION        = var.region
    KP_INSTANCE_ID    = var.kp_instance_id
    KP_KEY_ID         = var.kp_key_id
    PASSPHRASE        = var.passphrase
    RESOURCE_GROUP_ID = var.resource_group_id
  }
}

output "wrap" {
  value = shell_script.wrap.output
}
