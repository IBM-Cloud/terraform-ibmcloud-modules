data "shell_script" "vmware_host_physical_nic_with_mac_addr" {
  lifecycle_commands {
    read = file("${path.module}/scripts/read.sh")
  }
  environment = {
    GOVC_URL      = var.govc_url
    GOVC_USERNAME = var.govc_username
    GOVC_PASSWORD = var.govc_password
    GOVC_INSECURE = var.govc_insecure
    MAC_ADDR      = var.mac_addr


  }
  interpreter = ["/bin/bash", "-c"]
}

variable "govc_url" {}
variable "govc_username" { default = "root" }
variable "govc_password" {}
variable "govc_insecure" { default = "true" }
variable "mac_addr" {}


output "output" {
  value = data.shell_script.vmware_host_physical_nic_with_mac_addr.output
}
