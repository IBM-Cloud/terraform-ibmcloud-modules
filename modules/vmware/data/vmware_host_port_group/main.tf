data "shell_script" "vmware_host_port_group" {
  lifecycle_commands {
    read = file("${path.module}/scripts/read.sh")
  }
  environment = {
    GOVC_URL        = var.govc_url
    GOVC_USERNAME   = var.govc_username
    GOVC_PASSWORD   = var.govc_password
    GOVC_INSECURE   = var.govc_insecure
    HOST_PORT_GROUP = var.host_port_group
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "govc_url" {}
variable "govc_username" { default = "root" }
variable "govc_password" {}
variable "govc_insecure" { default = "true" }
variable "host_port_group" {}


output "output" {
  value = data.shell_script.vmware_host_port_group.output
}
