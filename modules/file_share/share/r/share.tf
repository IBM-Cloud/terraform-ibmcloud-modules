# IBM Confidential
# OCO Source Materials
# CLD-89892-1622659082
# (c) Copyright IBM Corp. 2021
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office


#########1#########2#########3#########4#########5#########6#########7#########8
# Variables
#########1#########2#########3#########4#########5#########6#########7#########8
variable "zone" {
  description = "Zone name"
  default     = "us-south-2"
}

variable "resource_group_id" {
  description = "Resource group ID"
}

variable "share_count" {
  description = "The number of shares to be created"
  default     = 2
}

variable "share_name" {
  description = "Share name"
}

variable "share_profile" {
  description = "Share profile"
  default     = "tier-3iops"
}

variable "share_size" {
  description  = "Share size in GB"
  default      = 1000
}

#########1#########2#########3#########4#########5#########6#########7#########8
# Resources
#########1#########2#########3#########4#########5#########6#########7#########8
resource "ibm_is_share" "this" {
  count          = var.share_count
  zone           = var.zone
  resource_group = var.resource_group_id
  name           = "${var.zone}-${var.share_name}-${count.index}"
  profile        = var.share_profile
  size           = var.share_size
}

#########1#########2#########3#########4#########5#########6#########7#########8
# Outputs
#########1#########2#########3#########4#########5#########6#########7#########8
output "shares" {
  value = ibm_is_share.this
}

output "share_ids" {
  value = [for share in ibm_is_share.this: share.id]
}
