data "shell_script" "is_baremetal_server_network_interface_floating_ip" {
  lifecycle_commands {
    read = file("${path.module}/scripts/read.sh")
  }
  environment = {
    IBM_REGION                              = var.ibm_region
    RESOURCE_GROUP                          = var.resource_group
    BM_SERVER                               = var.bm_server
    BM_SERVER_NETWORK_INTERFACE             = var.bm_server_network_interface
    BM_SERVER_NETWORK_INTERFACE_FLOATING_IP = var.bm_server_network_interface_floating_ip
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "ibm_region" {}
variable "resource_group" {}
variable "bm_server" {}
variable "bm_server_network_interface" {}
variable "bm_server_network_interface_floating_ip" {}

output "data_is_baremetal_server_network_interface_floating_ip" {
  value = data.shell_script.is_baremetal_server_network_interface_floating_ip.output
}
