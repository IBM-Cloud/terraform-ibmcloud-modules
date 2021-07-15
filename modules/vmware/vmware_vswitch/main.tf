resource "shell_script" "vmware_vswitch" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    read   = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }
  environment = {
    GOVC_URL      = var.govc_url
    GOVC_USERNAME = var.govc_username
    GOVC_PASSWORD = var.govc_password
    GOVC_INSECURE = var.govc_insecure
    HOST_VSWITCH  = var.host_vswitch
    HOST_NIC      = var.host_nic
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "govc_url" {}
variable "govc_username" { default = "root" }
variable "govc_password" {}
variable "govc_insecure" { default = "true" }
variable "host_vswitch" {}
variable "host_nic" {}


output "output" {
  value = shell_script.vmware_vswitch.output
}
