# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740458
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


variable "sg_name" {
  description = "Security group name"
}

variable "vpc_id" {
  description = "VPC id"
}

variable "resource_group_id" {
  description = "Resource group id"
}

resource "ibm_is_security_group" "this" {
  name           = var.sg_name
  vpc            = var.vpc_id
  resource_group = var.resource_group_id
}

resource "ibm_is_security_group_rule" "sg_icmp_rule" {
  group     = ibm_is_security_group.this.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  icmp {
    code = 0
    type = 8
  }

  depends_on = [ibm_is_security_group.this]
}

resource "ibm_is_security_group_rule" "sg_app_tcp_rule" {
  group     = ibm_is_security_group.this.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 80
    port_max = 80
  }

  depends_on = [ibm_is_security_group_rule.sg_icmp_rule]
}

resource "ibm_is_security_group_rule" "sg_app_ssh_rule" {
  group     = ibm_is_security_group.this.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 22
    port_max = 22
  }

  depends_on = [ibm_is_security_group_rule.sg_app_tcp_rule]
}

resource "ibm_is_security_group_rule" "ag_ob_rule" {
  group     = ibm_is_security_group.this.id
  direction = "outbound"
  remote    = "0.0.0.0/0"

  depends_on = [ibm_is_security_group_rule.sg_app_ssh_rule]
}

output "security_group" {
  value = ibm_is_security_group.this
}

output "security_group_id" {
  value = ibm_is_security_group.this.id
}

output "sg_last_rule" {
  value = ibm_is_security_group_rule.ag_ob_rule
}
