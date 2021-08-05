resource "shell_script" "vmware_datastore" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    read   = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }
  environment = {
    GOVC_URL       = var.govc_url
    GOVC_USERNAME  = var.govc_username
    GOVC_PASSWORD  = var.govc_password
    GOVC_INSECURE  = var.govc_insecure
    DATASTORE_NAME = var.datastore_name
    DISK_DEVICE    = var.disk_device
    HOST_NAME      = var.host_name
  }

  interpreter = ["/bin/bash", "-c"]
}

variable "govc_url" {}
variable "govc_username" { default = "root" }
variable "govc_password" {}
variable "govc_insecure" { default = "true" }
variable "datastore_name" {}
variable "disk_device" {}
variable "host_name" { default = "localhost.localdomain" }


output "output" {
  value = shell_script.vmware_datastore.output
}
