

variable region {}
variable kp_instance_id {}
variable kp_key_id {}
variable base64_dek {}
variable aad {}

resource "shell_script" "wrap" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  environment = {
    IBM_REGION     = var.region
    KP_INSTANCE_ID = var.kp_instance_id
    KP_KEY_ID      = var.kp_key_id
    BASE64_DEK     = var.base64_dek
    AAD            = var.aad
  }
}

output "wrap" {
  value = shell_script.wrap.output
}
