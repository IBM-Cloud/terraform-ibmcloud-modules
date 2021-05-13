

variable region { default="us-south" }
variable kp_instance_id {}
variable kp_key_id {}

resource "shell_script" "disable" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  environment = {
    IBM_REGION     = var.region
    KP_INSTANCE_ID = var.kp_instance_id
    KP_KEY_ID      = var.kp_key_id
  }
}

output "disable" {
  value = shell_script.disable.output
}
