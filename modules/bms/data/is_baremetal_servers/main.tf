data "shell_script" "is_baremetal_servers" {
  lifecycle_commands {
    read = file("${path.module}/scripts/read.sh")
  }
  environment = {
    IBM_REGION     = var.ibm_region
    RESOURCE_GROUP = var.resource_group
  }
  interpreter = ["/bin/bash", "-c"]
}

variable "ibm_region" {}
variable "resource_group" {}

output "data_is_baremetal_servers" {
  value = data.shell_script.is_baremetal_servers.output
}
