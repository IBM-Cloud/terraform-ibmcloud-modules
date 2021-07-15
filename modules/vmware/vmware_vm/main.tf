resource "shell_script" "vmware_vm" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    read   = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }
  environment = {
    GOVC_URL        = var.govc_url
    GOVC_USERNAME   = var.govc_username
    GOVC_PASSWORD   = var.govc_password
    GOVC_INSECURE   = var.govc_insecure
    GOVC_DSTORE     = var.govc_dstore
    VM_NAME         = var.vm_name
    MAC_ADDR        = var.mac_addr
    PORT_GROUP_NAME = var.port_group_name
    OPTION_JSON     = var.option_json
    OVA_PATH        = var.ova_path
  }

  interpreter = ["/bin/bash", "-c"]
}

variable "govc_url" {}
variable "govc_username" { default = "root" }
variable "govc_password" {}
variable "govc_insecure" { default = "true" }
variable "govc_dstore" { default = "datastore1" }
variable "vm_name" {}
variable "mac_addr" { default = "" }
variable "port_group_name" {}
variable "option_json" {}
variable "ova_path" {}


output "output" {
  value = shell_script.vmware_vm.output
}
