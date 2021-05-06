

variable region {default="us-south"}
variable instance_ids {type=list(string)}

resource "shell_script" "reboot" {
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

output "reboot" {
  value=[for item in shell_script.reboot: item.output]
}
