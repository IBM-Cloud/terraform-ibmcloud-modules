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
variable "share_ids" {
  description = "The list of share IDs"
  type        = list(string)
}

#########1#########2#########3#########4#########5#########6#########7#########8
# Data sources
#########1#########2#########3#########4#########5#########6#########7#########8
data "ibm_is_share" "this" {
  count = length(var.share_ids)
  share = var.share_ids[count.index]
}

#########1#########2#########3#########4#########5#########6#########7#########8
# Outputs
#########1#########2#########3#########4#########5#########6#########7#########8
output "shares" {
  value = data.ibm_is_share.this
}

output "share_lifecycle_states" {
  value = {for item in data.ibm_is_share.this: item.id => item.lifecycle_state}
}
