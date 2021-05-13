

variable region {default="us-south"}
variable resource_group_id {}
variable share_ids {type=list(string)}

data "shell_script" "share_targets" {
  lifecycle_commands {
    read   = file("${path.module}/scripts/read.sh")
  }
 
  count = length(var.share_ids)
  environment = {
    REGION            = var.region
    RESOURCE_GROUP_ID = var.resource_group_id
    SHARE_ID          = var.share_ids[count.index]
  }
}

output "share_targets" {
  value = [for item in data.shell_script.share_targets: item.output]
}

output "target_lifecycle_states" {
  value = {for item in data.shell_script.share_targets: item.output.id => item.output.lifecycle_state}
}

