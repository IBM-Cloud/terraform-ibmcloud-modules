resource "shell_script" "vmware_host_option" {
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
    OPTION_KEY    = var.option_key
    OPTION_VALUE  = var.option_value
  }

  interpreter = ["/bin/bash", "-c"]
}

variable "govc_url" {}
variable "govc_username" { default = "root" }
variable "govc_password" {}
variable "govc_insecure" { default = "true" }
variable "option_key" {}
variable "option_value" {}


output "output" {
  value = shell_script.vmware_host_option.output
}
