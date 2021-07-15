data "shell_script" "is_baremetal_server_disk" {
  lifecycle_commands {
    read = file("${path.module}/scripts/read.sh")
  }
  environment = {
    IBM_REGION     = var.ibm_region
    RESOURCE_GROUP = var.resource_group
    BM_SERVER      = var.bm_server
    BM_SERVER_DISK = var.bm_server_disk
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "ibm_region" {}
variable "resource_group" {}
variable "bm_server" {}
variable "bm_server_disk" {}

output "data_is_baremetal_server_disk" {
  value = data.shell_script.is_baremetal_server_disk.output
}
