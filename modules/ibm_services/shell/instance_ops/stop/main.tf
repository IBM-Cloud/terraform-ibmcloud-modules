# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740515
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable region {default="us-south"}
variable instance_ids {
  type    =list(string)
  default = []
}

resource "shell_script" "stop" {
  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    delete = file("${path.module}/scripts/delete.sh")
    #read   = file("${path.module}/scripts/read.sh")
  }

  count = length(var.instance_ids) 
  environment = {
    IBM_REGION        = var.region
    INSTANCE_ID       = var.instance_ids[count.index]
  }
}

output "stop" {
  value = [for item in shell_script.stop: item.output] 
}
