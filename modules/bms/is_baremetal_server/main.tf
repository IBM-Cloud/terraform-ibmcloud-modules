resource "shell_script" "is_baremetal_server" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    read   = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }

  environment = {
    RESOURCE_GROUP               = var.resource_group
    IBM_REGION                   = var.ibm_region
    BM_SERVER_NAME               = var.bm_server_name
    BM_SERVER_ZONE               = var.bm_server_zone
    BM_SERVER_PROFILE            = var.bm_server_profile
    BM_SERVER_IMAGE              = var.bm_server_image
    BM_SERVER_KEYS               = var.bm_server_keys
    BM_SERVER_USERDATA           = var.bm_server_userdata
    BM_SERVER_PNIC_NAME          = var.bm_server_pnic_name
    BM_SERVER_PNIC_SUBNET        = var.bm_server_pnic_subnet
    BM_SERVER_PNIC_ALLOWED_VLANS = var.bm_server_pnic_allowed_vlans
    BM_SERVER_PNIC_EIN           = var.bm_server_pnic_ein
    BM_SERVER_PNIC_AIS           = var.bm_server_pnic_ais
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "ibm_region" {}
variable "resource_group" {}
variable "bm_server_name" {}
variable "bm_server_zone" {}
variable "bm_server_profile" {}
variable "bm_server_image" {}
variable "bm_server_keys" {}
variable "bm_server_userdata" {}
variable "bm_server_pnic_name" {}
variable "bm_server_pnic_subnet" {}
variable "bm_server_pnic_allowed_vlans" {}
variable "bm_server_pnic_ein" {}
variable "bm_server_pnic_ais" {}

output "output" {
  value = shell_script.is_baremetal_server.output
}
