

variable region {}
variable name {}
variable service {}
variable plan {}

resource "shell_script" "kp_instance" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    read   = file("${path.module}/scripts/read.sh")
  }
 
  environment = {
    IBM_REGION = var.region
    NAME       = var.name
    SERVICE    = var.service
    PLAN       = var.plan
    LOCATION   = var.region
  }
}

output "kp_instance" {
  value = shell_script.kp_instance.output
}
