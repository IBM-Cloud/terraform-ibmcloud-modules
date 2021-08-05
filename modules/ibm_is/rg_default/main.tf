# IBM Confidential
# OCO Source Materials
# CLD-68685-1602740457
# (c) Copyright IBM Corp. 2020
# The source code for this program is not published or otherwise
# divested of its trade secrets, irrespective of what has been
# deposited with the U.S. Copyright Office.


data "ibm_resource_group" "default" {
  name = "Default"
}

output "resource_group" {
  value = data.ibm_resource_group.default
}

output "resource_group_id" {
  value = data.ibm_resource_group.default.id
}

