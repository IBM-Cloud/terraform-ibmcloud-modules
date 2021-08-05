resource "shell_script" "is_baremetal_server_network_interface" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    read   = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }
  environment = {
    IBM_REGION                                            = var.ibm_region
    RESOURCE_GROUP                                        = var.resource_group
    SUBNET_ID                                             = var.subnet_id
    SECURITY_GROUP_ID                                     = var.security_group_id
    BM_SERVER                                             = var.bm_server_id
    BM_SERVER_NETWORK_INTERFACE_NAME                      = var.bm_server_network_interface_name
    BM_SERVER_NETWORK_INTERFACE_ID                        = var.bm_server_network_interface_id
    BM_SERVER_NETWORK_INTERFACE_TYPE                      = var.bm_server_network_interface_type
    BM_SERVER_NETWORK_INTERFACE_IP                        = var.bm_server_network_interface_ip
    BM_SERVER_NETWORK_INTERFACE_ALLOWED_VLANS             = var.bm_server_network_interface_allowed_vlans
    BM_SERVER_NETWORK_INTERFACE_VLAN                      = var.bm_server_network_interface_vlan
    BM_SERVER_NETWORK_INTERFACE_ALLOW_INTERFACE_TO_FLOAT  = var.bm_server_network_interface_allow_interface_to_float
    BM_SERVER_NETWORK_INTERFACE_ALLOW_IP_SPOOFING         = var.bm_server_network_interface_allow_ip_spoofing
    BM_SERVER_NETWORK_INTERFACE_ENABLE_INFRASTRUCTURE_NAT = var.bm_server_network_interface_enable_infrastructure_nat
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "ibm_region" {}
variable "resource_group" {}
variable "subnet_id" {}
variable "security_group_id" { default = "" }
variable "bm_server_id" {}
variable "bm_server_network_interface_name" {}
variable "bm_server_network_interface_id" { default = "" }
variable "bm_server_network_interface_type" {}
variable "bm_server_network_interface_ip" { default = "" }
variable "bm_server_network_interface_allowed_vlans" { default = "" }
variable "bm_server_network_interface_vlan" {}
variable "bm_server_network_interface_allow_interface_to_float" { default = "" }
variable "bm_server_network_interface_allow_ip_spoofing" { default = "" }
variable "bm_server_network_interface_enable_infrastructure_nat" { default = "" }

output "output" {
  value = shell_script.is_baremetal_server_network_interface.output
}
