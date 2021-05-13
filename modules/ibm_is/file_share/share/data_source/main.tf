

variable region {}
variable resource_group_id {}
variable share_ids {type=list(string)}

data "shell_script" "shares" {
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

output "shares" {
  value = [for item in data.shell_script.shares: item.output]
}

output "share_lifecycle_states" {
  value = {for item in data.shell_script.shares: item.output.id => item.output.lifecycle_state}
}
