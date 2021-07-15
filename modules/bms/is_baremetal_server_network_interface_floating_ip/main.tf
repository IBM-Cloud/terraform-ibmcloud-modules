resource "shell_script" "is_baremetal_server_network_interface_floating_ip" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    read   = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }

  environment = {
    RESOURCE_GROUP                             = var.resource_group
    IBM_REGION                                 = var.ibm_region
    BM_SERVER_ID                               = var.bm_server_id
    BM_SERVER_NETWORK_INTERFACE_ID             = var.bm_server_network_interface_id
    BM_SERVER_NETWORK_INTERFACE_FLOATING_IP_ID = var.bm_server_network_interface_floating_ip_id

  }

  interpreter = ["/bin/bash", "-c"]
}

variable "ibm_region" {}
variable "resource_group" {}
variable "bm_server_id" {}
variable "bm_server_network_interface_id" {}
variable "bm_server_network_interface_floating_ip_id" {}

output "output" {
  value = shell_script.is_baremetal_server_network_interface_floating_ip.output
}
