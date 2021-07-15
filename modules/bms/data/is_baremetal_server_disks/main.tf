data "shell_script" "is_baremetal_server_disks" {
  lifecycle_commands {
    read = file("${path.module}/scripts/read.sh")
  }
  environment = {
    IBM_REGION     = var.ibm_region
    RESOURCE_GROUP = var.resource_group
    BM_SERVER      = var.bm_server
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "ibm_region" {}
variable "resource_group" {}
variable "bm_server" {}

output "data_is_baremetal_server_disks" {
  value = data.shell_script.is_baremetal_server_disks.output
}
