data "shell_script" "is_baremetal_server_network_interfaces" {
  lifecycle_commands {
    read = file("${path.module}/scripts/read.sh")
  }
  environment = {
    IBM_REGION     = var.ibm_region
    RESOURCE_GROUP = var.resource_group
    BM_SERVER      = var.bm_server_id
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "ibm_region" {}
variable "resource_group" {}
variable "bm_server_id" {}

output "output" {
  value = data.shell_script.is_baremetal_server_network_interfaces.output
}
