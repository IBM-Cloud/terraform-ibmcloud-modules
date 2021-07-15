resource "shell_script" "vmware_host_port_group" {
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
    HOST_VSWITCH    = var.host_vswitch
    HOST_VLAN       = var.host_vlan
    HOST_PORT_GROUP = var.host_port_group
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "govc_url" {}
variable "govc_username" { default = "root" }
variable "govc_password" {}
variable "govc_insecure" { default = "true" }
variable "host_port_group" {}
variable "host_vswitch" {}
variable "host_vlan" {}


output "output" {
  value = shell_script.vmware_host_port_group.output
}
