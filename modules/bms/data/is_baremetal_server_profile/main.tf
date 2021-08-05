data "shell_script" "is_baremetal_server_profile" {
  lifecycle_commands {
    read = file("${path.module}/scripts/read.sh")
  }
  environment = {
    IBM_REGION     = var.ibm_region
    RESOURCE_GROUP = var.resource_group
    BM_PROFILE     = var.bm_profile
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "ibm_region" {}
variable "resource_group" {}
variable "bm_profile" {}

output "data_is_baremetal_server_profile" {
  value = data.shell_script.is_baremetal_server_profile.output
}
