

variable region {}
variable kp_instance_id {}
variable kp_key_id {}
variable aad {}
variable ciphertext {}

resource "shell_script" "unwrap" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  environment = {
    IBM_REGION     = var.region
    KP_INSTANCE_ID = var.kp_instance_id
    KP_KEY_ID      = var.kp_key_id
    AAD            = var.aad
    CIPHERTEXT     = var.ciphertext
  }
}

output "unwrap" {
  value = shell_script.unwrap.output
}
