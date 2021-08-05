data "shell_script" "is_baremetal_server_console" {
  lifecycle_commands {
    read = file("${path.module}/scripts/read.sh")
  }
  environment = {
    IBM_REGION     = var.ibm_region
    RESOURCE_GROUP = var.resource_group
    BM_SERVER      = var.bm_server_id
    BM_SERVER_VNC  = var.bm_server_vnc
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "ibm_region" {}
variable "resource_group" {}
variable "bm_server_id" {}
variable "bm_server_vnc" { default = "" }

output "output" {
  value = data.shell_script.is_baremetal_server_console.output
}
